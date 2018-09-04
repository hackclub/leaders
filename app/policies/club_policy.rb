class ClubPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    record.new_leaders.select(email: user.email) || user.admin?
  end
end
