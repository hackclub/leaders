class MeetingPolicy < ApplicationPolicy
  def show?
    user.admin? || record.club.api_record['new_leaders'].map{ |l| l['email'] }.include?(user.email)
  end

  def edit?
    user.admin? || record.club.api_record['new_leaders'].map{ |l| l['email'] }.include?(user.email)
  end

  def update?
    user.admin? || record.club.api_record['new_leaders'].map{ |l| l['email'] }.include?(user.email)
  end

  def destroy?
    user.admin? || record.club.api_record['new_leaders'].map{ |l| l['email'] }.include?(user.email)
  end
end
