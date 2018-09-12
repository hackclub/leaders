class Club < ApplicationRecord
  validates_presence_of :api_id, :slug, :name
  validates_uniqueness_of :api_id, :slug

  has_and_belongs_to_many :users
  has_many :subdomains

  def to_param
    slug
  end
end
