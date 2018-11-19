class Post < ApplicationRecord
  belongs_to :club
  belongs_to :user

  validates_presence_of :name, :file
  validates :name, length: { minimum: 6, too_short: '– write a more descriptive title' }
  
  has_one_attached :file
end
