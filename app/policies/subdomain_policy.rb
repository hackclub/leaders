class SubdomainPolicy < ApplicationPolicy
  def index?
    user.admin? || user.leader?
  end

  def show?
    user.admin? || user.clubs.map(&:id).include?(record.club_id)
  end

  def edit?
    user.admin? || user.clubs.map(&:id).include?(record.club_id)
  end

  def update?
    user.admin? || user.clubs.map(&:id).include?(record.club_id)
  end

  def create?
    user.admin? || user.clubs.map(&:id).include?(record.club_id)
  end

  def destroy?
    user.admin? || user.clubs.map(&:id).include?(record.club_id)
  end
end
