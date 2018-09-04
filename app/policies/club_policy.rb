class ClubPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    record.users.include?(user) || user.admin?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end
end
