class DnsRecord < ApplicationRecord
  def self.record_types
    %i(CNAME A)
  end

  enum record_type: record_types

  belongs_to :user
  belongs_to :subdomain
  has_one :change_request

  validates_presence_of :user_id, :value, :record_type
  validates_uniqueness_of :record_type, scope: [:subdomain, :deleted_at], if: -> { deleted_at.nil? }

  default_scope { where(deleted_at: nil) }
  scope :include_deleted, -> { unscope(:where) }

  after_save do |dns_record|
    # Get the branch's open PR or create a new one
    subdomain.pull_requests.active.each(&:update_github_status)
    active_pr = subdomain.pull_requests.order(:created_at).active.last

    if active_pr
      active_pr.update_github_changes(subdomain)
    else
      PullRequest.create!(subdomain: subdomain)
    end
  end
end
