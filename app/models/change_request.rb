class ChangeRequest < ApplicationRecord

  def self.record_types
    %i(CNAME A)
  end

  enum record_type: record_types

  belongs_to :user
  belongs_to :subdomain

  validates_uniqueness_of :pr_url
  validates_presence_of :pr_url, :club_id, :user_id, :name, :value, :record_type

  before_create :submit_url


  private

  def submit_pull_request
    pr_url = SubdomainService.append_subdomain(name, record_type, value)
    self.pr_url = pr_url
  end
end
