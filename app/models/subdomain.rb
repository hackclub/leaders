class Subdomain < ApplicationRecord
  validates_uniqueness_of :club_id, :name
  validates_presence_of :club_id, :name

  def slug
    name
  end

  def to_param
    slug
  end

  def full_url
    "#{name}.hackclub.com"
  end
end
