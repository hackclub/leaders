require 'octokit'
require 'base64'
require 'yaml'


class GithubService
  REPO = "hackclub/dns"
  FILE = "hackclub.com.yaml"

  def self.append_subdomain(subdomain, type, value)
    old_file = client.contents(REPO, path: FILE)
    blob_sha = old_file.sha

    head_sha = client.ref(REPO, "heads/master")[:object][:sha]
    branches = client.branches(REPO).pluck(:name)

    new_branch_name = branch_name(branches, subdomain)
    new_ref_name    = "heads/#{new_branch_name}"

    client.create_ref(REPO, new_ref_name, head_sha)

    new_content = updated_content(old_file.content, subdomain, type, value)

    message = "#{type} record for #{subdomain}.hackclub.com"

    client.update_contents(REPO, FILE, message, blob_sha, new_content, branch: new_branch_name)

    pull_request = client.create_pull_request(REPO, "master", new_branch_name, message)
    pull_request[:html_url]
  end

  def self.subdomain_available?(name)
    used_subdomains = get_content.keys
    !used_subdomains.include? name
  end

  def self.get_content
    decoded_content = Base64.decode64(client.contents(REPO, path: FILE).content)
    YAML.load(decoded_content)
  end

  private

  def self.updated_content(content, subdomain, type, value)
    decoded_content = Base64.decode64(content)
    data = YAML.load(decoded_content)
    data[subdomain] = {
      ttl: 1,
      type: type,
      value: "#{value}."
    }
    sorted_data = Hash[ data.sort_by { |key, val| key } ]
    sorted_data.to_yaml
  end

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
