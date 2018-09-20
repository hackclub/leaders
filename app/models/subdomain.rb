class Subdomain < ApplicationRecord
  validates_uniqueness_of :name, case_sensitive: false
  validates_presence_of :name
  validates :name, format: { with: URI::DEFAULT_PARSER.regexp[:HOST] }
  validate :vacant_subdomain_name, if: :name_changed?

  has_many :dns_records
  has_many :pull_requests
  belongs_to :club

  before_update :create_pr, if: :name_changed?

  def slug
    name
  end

  def to_param
    slug
  end

  def full_url
    "#{name}.hackclub.com"
  end

  def status
    pull_requests.active.each(&:update_github_status)
    active_pr = pull_requests.order(:created_at).active.last

    return :under_review if active_pr

    outddated_record = dns_records.any?(&:offline?)

    return :propigating if outddated_record

    return :success
  end

  def status_type
    case status
    when :under_review then :pending
    when :propigating then :info
    when :success then :success
    end
  end

  def status_description
    case status
    when :under_review then 'Under review'
    when :propigating then 'Propigating – this may take a few hours'
    when :success then 'Online!'
    end
  end

  private

  def vacant_subdomain_name
    errors.add(:name, 'is protected') if protected_subdomains.include?(name)
    errors.add(:name, 'already taken') if GithubService.subdomain_taken?(name)
  end

  def protected_subdomains
    # This is all from https://github.com/hackclub/proxy
    %w{
      admin blog board camp-sheet chicagohacks clubs conduct deals demo-night
      design donate dropbox exit-interview feedback-redir feedback find finder
      free-tech-domain gh guide hack-camp-playbook idyllwild india internships
      irc orbit partytime proxyparty schedule-interview schedule-orientation
      series shipit shipped slack subscribe wildcard workshops www
    }
  end

  def create_pr
    pull_requests.active.each(&:update_github_status)
    active_pr = pull_requests.order(:created_at).active.last

    if active_pr
      active_pr.update_github_changes(self)
    else
      PullRequest.create!(subdomain: self)
    end
  end
end
