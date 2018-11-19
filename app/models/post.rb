class Post < ApplicationRecord
  belongs_to :club
  belongs_to :user

  validates_presence_of :name, :file
  validates :name, length: { minimum: 6, too_short: '– write a more descriptive title' }
  
  has_one_attached :file

  validate :file_validation

  def file_validation
    if file.attached?
      if file.blob.byte_size > 5000000
        file.purge
        errors[:file] << '– too large (5MB limit)'
      elsif !file.blob.content_type.starts_with?('image/')
        file.purge
        errors[:file] << '— only images are supported'
      end
    end
  end
end
