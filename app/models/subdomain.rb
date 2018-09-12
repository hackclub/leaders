class Subdomain < ApplicationRecord
  validates_uniqueness_of :club_id, :name
  validates_presence_of :club_id, :name
  validate :vacant_subdomain_name, on: :create

  has_many :change_requests
  belongs_to :club

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
end
