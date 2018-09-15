class DnsRecordPolicy < ApplicationPolicy
  def index?
    user.admin? || user.leader?
  end

  def show?
    user.admin? || user.dns_records.include?(record)
  end

  def edit?
    user.admin? || user.dns_records.include?(record)
  end

  def update?
    user.admin? || user.clubs.collect(&:subdomains).flatten.include?(record.subdomain)
  end

  def create?
    user.admin? || user.clubs.collect(&:subdomains).flatten.include?(record.subdomain)
  end

  def destroy?
    user.admin? || user.dns_records.include?(record)
  end
end
