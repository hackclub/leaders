class DnsRecord < ApplicationRecord
  def self.record_types
    %i(CNAME A)
  end

  enum record_type: record_types

  belongs_to :user
  belongs_to :subdomain

  validates_presence_of :user_id, :value, :record_type

  private

  def submit_pull_request
    pr_url = SubdomainService.append_subdomain(record_type, value)
    self.pr_url = pr_url
  end
end
