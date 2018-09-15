class SubdomainPolicy < ApplicationPolicy
  def index?
    user.admin? || user.leader?
  end

  def show?
    user.admin? || user.clubs.collect(&:subdomains).flatten.include?(record)
  end

  def edit?
    user.admin? || user.clubs.collect(&:subdomains).flatten.include?(record)
  end

  def update?
    user.admin? || user.clubs.collect(&:subdomains).flatten.include?(record)
  end

  def create?
    user.admin? || user.clubs.collect(&:subdomains).flatten.include?(record)
  end
end
