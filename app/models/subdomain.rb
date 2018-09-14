class Subdomain < ApplicationRecord
  validates_uniqueness_of :club_id, :name
  validates_presence_of :club_id, :name
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

  private

  def vacant_subdomain_name
    return if GithubService.subdomain_available? name
    errors.add(:name, 'already taken')
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
