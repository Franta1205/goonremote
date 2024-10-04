class CompanyPolicy < ApplicationPolicy
  def create?
    record.user_id == user.id
  end

  def edit?
    create?
  end

  def update
    create?
  end
end
