class JobPolicy < ApplicationPolicy
  def create?
    return true if admin?

    owner?
  end

  def edit?
    return true if admin?

    owner?
  end

  def show?
    return true if record.active?

    owner?
  end

  def update?
    edit?
  end

  def destroy?
    !record.active? && owner?
  end

  private

  def owner?
    record.company.user_id == user.id
  end
end
