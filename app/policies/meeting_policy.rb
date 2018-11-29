class MeetingPolicy < ApplicationPolicy
  def show?
    user.admin? || meeting.club.api_record['new_leaders'].map{ |l| l['email'] }.include?(user.email)
  end

  def edit?
    user.admin? || meeting.club.api_record['new_leaders'].map{ |l| l['email'] }.include?(user.email)
  end

  def update?
    user.admin? || meeting.club.api_record['new_leaders'].map{ |l| l['email'] }.include?(user.email)
  end
end
