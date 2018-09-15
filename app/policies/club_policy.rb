class ClubPolicy < ApplicationPolicy
  def index?
    user.admin? || user.leader?
  end

  def show?
    user.admin? || record.api_record['new_leaders'].find(email: user.email)
  end
end
