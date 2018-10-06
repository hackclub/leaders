require 'octokit'
require 'base64'
require 'yaml'


class GithubService
  REPO = "hackclub/dns"
  FILE = "hackclub.com.yaml"

  def self.generate_and_submit_pr(subdomain)
    dns_data = get_dns_records

    if subdomain.changes
      old_name = subdomain&.changes[:name]&.first
      dns_data.delete old_name
    end

    if subdomain.dns_records.any?
      dns_data[subdomain[:name]] = []
      subdomain.dns_records.each do |dns_record|
        add_dns_record(dns_data, subdomain, dns_record[:record_type], dns_record[:value])
      end
    end

    sorted_dns_data = sort_records dns_data
    create_pr(sorted_dns_data.to_yaml, "Update #{subdomain[:name]}.hackclub.com", subdomain[:name])
  end

  def self.update_pr(pr)
    pr_gh = client.pull_request(REPO, pr[:number])
    blob_sha = client.contents(REPO, path: FILE, ref: pr_gh[:head][:ref]).sha
    head_sha = pr_gh[:head][:sha]
    subdomain = pr.subdomain

    dns_data = get_dns_records(pr_gh[:head][:ref])

    if subdomain.changes
      old_name = subdomain&.changes[:name]&.first
      dns_data.delete old_name
    end

    dns_data.delete subdomain.name

    if subdomain.dns_records.any?
      dns_data[subdomain[:name]] = []
      subdomain.dns_records.each do |dns_record|
        add_dns_record(dns_data, subdomain, dns_record[:record_type], dns_record[:value])
      end
    end

    sorted_dns_data = sort_records dns_data
    client.update_contents(REPO, FILE, "Update #{subdomain[:name]}.hackclub.com", blob_sha, sorted_dns_data.to_yaml, branch: pr_gh[:head][:ref])
  end

  def self.create_pr(content, message, subdomain_name)
    blob_sha = client.contents(REPO, path: FILE).sha
    head_sha = client.ref(REPO, "heads/master")[:object][:sha]
    branches = client.branches(REPO).pluck(:name)

    new_branch_name = branch_name(branches, subdomain_name)
    new_ref_name    = "heads/#{new_branch_name}"
    client.create_ref(REPO, new_ref_name, head_sha)

    client.update_contents(REPO, FILE, message, blob_sha, content, branch: new_branch_name)

    pull_request = client.create_pull_request(REPO, "master", new_branch_name, message)
  end

  def self.subdomain_taken?(name)
    used_subdomains = get_dns_records.keys
    used_subdomains.map(&:downcase).include? name.downcase
  end

  def self.client
    client
  end

  def self.get_dns_records(ref = "master")
    decoded_content = Base64.decode64(client.contents(REPO, path: FILE, ref: ref).content)
    YAML.load(decoded_content)
  end

  private

  def self.add_dns_record(content, subdomain, record_type, value)
    content[subdomain[:name]] << {
      'ttl' => 1,
      'type' => record_type,
      'value' => record_type == "CNAME" ? "#{value}." : value
    }
    content
  end

  def self.sort_records(records)
    sorted_data = Hash[ records.sort_by { |key, val| key } ]
  end

  # Format: YYYY-MM-DD_add_example_hackclub_com
  #
  # Padded numbers will be appended at the end of the branch name if a branch
  # already exists with the given name.
  def self.branch_name(existing_branches, subdomain, snake_case = true)
    base = snake_case ? "#{Date.current.iso8601}_add_#{subdomain}_hackclub_com" : "#{Date.current.iso8601} add #{subdomain}.hackclub.com"
    name = base

    count = 2

    while existing_branches.include? name
      padded_num = count.to_s.rjust(2, '0')
      name = base + '-' + padded_num

      count += 1
    end

    name
  end

  def self.client
    @client ||= Octokit::Client.new(access_token: Rails.application.credentials[:github_token])
    @client.auto_paginate = true
    return @client
  end
end
