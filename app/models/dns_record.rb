class DnsRecord < ApplicationRecord
  def self.record_types
    %i(CNAME A AAAA TXT)
  end

  enum record_type: record_types

  belongs_to :user
  belongs_to :subdomain
  has_one :change_request

  validates_presence_of :user_id, :value, :record_type
  validates_uniqueness_of :record_type, scope: :subdomain, conditions: -> { where(deleted_at: nil) }

  validates :value, format: { with: Resolv::IPv4::Regex, message: 'invalid IPv4 address' }, if: -> { record_type == 'A' }
  validates :value, format: { with: Resolv::IPv6::Regex, message: 'invalid IPv6 address' }, if: -> { record_type == 'AAAA' }
  validates :value, format: { with: URI::DEFAULT_PARSER.regexp[:HOST], message: 'invalid hostname' }, if: -> { record_type == 'CNAME' }

  default_scope { where(deleted_at: nil) }
  scope :include_deleted, -> { unscope(:where) }

  def status
    online = DnsService.check(record_type, subdomain.full_url, value)
    online ? :online : :offline
  end

  def status_type
    case status
    when :online then :success
    when :offline then :muted
    end
  end

  def online?
    status == :online
  end

  def offline?
    status == :offline
  end

  after_save do |dns_record|
    if dns_record.changes.any?
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
end
