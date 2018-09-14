class PullRequest < ApplicationRecord
  validates_presence_of :number, :repo
  validates_uniqueness_of :number

  before_validation :init_on_github, on: :create

  belongs_to :subdomain

  scope :active, -> { where(closed_at: nil, merged_at: nil) }

  def active?
    closed_at.nil? && merged_at.nil?
  end

  def update_github_status
    gh_pr = GithubService.client.pull_request(repo, number)

    self.update(
      closed_at: gh_pr[:closed_at],
      merged_at: gh_pr[:merged_at]
    )
  end

  def merged?
    !merged_at.blank?
  end

  def update_github_changes(subdomain)
    GithubService.update_pr(self)
  end

  private

  def init_on_github
    gh_pr = GithubService.generate_and_submit_pr(subdomain)
    self.number = gh_pr[:number]
    self.repo = "maxwofford/dns"
  end
end
