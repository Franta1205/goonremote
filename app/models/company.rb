class Company < ApplicationRecord
  belongs_to :user
  has_one_attached :logo
  has_many :jobs

  validates :name, presence: {message: "can't be blank"}
  validates :description, presence: {message: "can't be blank"}
  validates :website_url, presence: {message: "can't be blank"}

  def shorten_description
    max_length = 60
    if description.length > max_length
      "#{description[0...max_length]}..." # Cuts the title and adds ellipsis
    else
      description
    end
  end
end
