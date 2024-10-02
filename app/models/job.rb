class Job < ApplicationRecord
  belongs_to :company

  validates :title, presence: {message: "can't be blank"}
  validates :description, presence: {message: "can't be blank"}

  def resolved_salary
    rounded_min = salary_min.present? ? (salary_min / 1000).round : nil
    rounded_max = salary_max.present? ? (salary_max / 1000).round : nil

    if rounded_min.present? && rounded_max.present?
      "#{currency}#{rounded_min}k - #{currency}#{rounded_max}k"
    elsif rounded_max.present? && !rounded_min.present?
      "#{currency}#{rounded_max}k"
    end
  end

  def job_owner?(user:)
    company.user == user
  end
end
