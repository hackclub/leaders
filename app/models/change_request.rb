class ChangeRequest < ApplicationRecord
  enum type: %i(CNAME A)

  belongs_to :user
  belongs_to :subdomain

  validates_uniqueness_of :pr_url
  validates_presence_of :pr_url, :club_id, :user_id, :name, :value, :type

  before_create :submit_url

  private

  def submit_pull_request
    pr_url = SubdomainService.append_subdomain(name, type, value)
    self.pr_url = pr_url
  end
end
