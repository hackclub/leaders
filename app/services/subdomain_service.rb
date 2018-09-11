require 'octokit'
require 'base64'
require 'yaml'


class SubdomainService
  REPO = "prophetorpheus/dns"
  FILE = "hackclub.com.yaml"

  def self.append_subdomain(subdomain, host)
    old_file = client.contents(REPO, path: FILE)

    head_sha = client.ref(REPO, "heads/master")[:object][:sha]
    branches = client.refs(REPO).pluck(:name)

    new_branch_name = branch_name(branches, subdomain)
    new_ref_name    = "heads/#{new_branch_name}"

    client.create_ref(REPO, new_ref_name, head_sha)
    contents = client.contents(REPO, ref: new_ref_name, path: FILE)

    decoded_content = Base64.decode64(old_file.content)

    new_content = YAML.load(decoded_content + subdomain + ":\n  ttl: 1\n  type: CNAME\n  value: " + host + ".")
    sorted = Hash[ new_content.sort_by { |key, val| key } ]

    message = "#{decoded_content[subdomain].nil? ? 'add' : 'update'} subdomain #{subdomain}"

    blob_sha = contents.sha

    client.update_contents(REPO, FILE, message, blob_sha, sorted.to_yaml, branch: new_branch_name)

    client.create_pull_request(REPO, "master", new_branch_name, "#{Time.now} #{message}")
  end

  private

  # Format: YYYY-MM-DD_add_example_hackclub_com
  #
  # Padded numbers will be appended at the end of the branch name if a branch
  # already exists with the given name.
  def self.branch_name(existing_branches, subdomain)
    base = "#{Date.current.iso8601}_add_#{subdomain}_hackclub_com"
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
  end
end
