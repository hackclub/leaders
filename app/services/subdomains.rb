require 'octokit'
require 'base64'
require 'yaml'

class Subdomains
  $client = Octokit::Client.new(access_token: Rails.application.credentials[:github_token])
  contents = $client.contents("hackclub/dns", :path => "hackclub.com.yaml")
  $decoded_content = Base64.decode64(contents.content)
  $blob_sha = contents.sha

  def self.append_subdomain(subdomain, host)
    message = ""
    new_content = YAML.load($decoded_content + subdomain + ":\n  ttl: 1\n  type: CNAME\n  value: " + host + ".")
    sorted = Hash[ new_content.sort_by { |key, val| key } ]

    if $decoded_content[subdomain] != nil
      message = "update subdomain #{subdomain}"
    else
      message = "add subdomain #{subdomain}"
    end

    $client.update_contents("hackclub/dns", "hackclub.com.yaml", message, $blob_sha, sorted.to_yaml)
  end
