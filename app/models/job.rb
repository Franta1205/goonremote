class Job < ApplicationRecord
  belongs_to :company

  validates :title, presence: {message: "can't be blank"}
  validates :description, presence: {message: "can't be blank"}

  # Scope to fetch only active jobs (approved within the last month and not rejected)
  scope :active, -> { where("published_at IS NOT NULL AND published_at >= ? AND rejected_at IS NULL", 1.month.ago) }

  # Scope to fetch inactive jobs (older than a month, or not approved, excluding rejected jobs)
  scope :inactive, -> { where("published_at IS NULL OR published_at < ?", 1.month.ago).where(rejected_at: nil) }

  # Scope to fetch rejected jobs
  scope :rejected, -> { where.not(rejected_at: nil) }

  def resolved_salary
    rounded_min = salary_min.present? ? (salary_min / 1000).round : nil
    rounded_max = salary_max.present? ? (salary_max / 1000).round : nil

    if rounded_min.present? && rounded_max.present?
      "#{currency}#{rounded_min}k - #{currency}#{rounded_max}k"
    elsif rounded_max.present? && !rounded_min.present?
      "#{currency}#{rounded_max}k"
    end
  end

  def can_be_edited?(user:)
    job_owner?(user:) && inactive? || rejected?
  end

  def job_owner?(user:)
    company.user == user
  end

  def active?
    published_at.present? && published_at >= 1.month.ago
  end

  def inactive?
    !active? && !rejected?
  end

  def rejected?
    rejected_at.present?
  end

  def activate!
    update(published_at: Time.now, rejected_at: nil)
  end

  def reject!
    update(rejected_at: Time.now)
  end

  def inactiavte!
    update(rejected_at: nil, published_at: nil)
  end
end
