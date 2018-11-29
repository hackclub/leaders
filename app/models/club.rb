class Club < ApplicationRecord
  validates_presence_of :api_id, :slug, :name
  validates_uniqueness_of :api_id, :slug

  has_and_belongs_to_many :users
  has_many :subdomains
  has_many :meetings

  has_many :posts

  def to_param
    slug
  end

  def users
    api_record['new_leaders'].map{ |l| User.find_by(email: l['email']) }
  end

  def meeting_day
    # 5, Friday, is the assumed meeting day for clubs that haven't started meeting
    self.meetings.count > 0 ? self.meetings.last.start_time.wday : 5
  end
end
