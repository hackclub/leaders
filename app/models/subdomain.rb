class Subdomain < ApplicationRecord
  validates_uniqueness_of :club_id, :name
  validates_presence_of :club_id, :name
end
