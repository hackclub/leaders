class User < ApplicationRecord
  before_create :create_session_token

  has_many :dns_records
  has_and_belongs_to_many :clubs

  validates_presence_of :api_id, :api_access_token, :email
  validates_uniqueness_of :api_id, :api_access_token, :email

  def self.new_session_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def admin_at
    api_record[:admin_at]
  end

  def admin?
    self.admin_at.present?
  end

  def leader
    api_record[:new_leader]
  end

  def leader?
    self.leader.present?
  end

  def club
    clubs.first
  end

  def api_record
    @api_record ||= ApiService.get_user(self.api_id, self.api_access_token)
  end

  private

  def create_session_token
    self.session_token = User.digest(User.new_session_token)
  end
end
