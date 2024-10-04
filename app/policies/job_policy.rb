class JobPolicy < ApplicationPolicy
  def create?
    return true if admin?

    owner?
  end

  def edit?
    return true if admin?

    owner?
  end

  def update?
    edit?
  end

  def publish?
    admin?
  end

  def confirm_publish?
    admin?
  end

  def pending_jobs?
    admin?
  end

  private

  def owner?
    record.company.user_id == user.id
  end
end
