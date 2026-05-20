class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :category, presence: true, inclusion: { in: %w[chinese italian japanese french belgian] }

  def average_rating
    reviews.average(:rating).to_i
  end

  def self.top(n = 5)
    left_joins(:reviews)
      .group(:id)
      .sort_by { |restaurant| restaurant.average_rating }
      .reverse
      .first(n)
  end
end
