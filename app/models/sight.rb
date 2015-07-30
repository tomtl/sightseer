class Sight < ActiveRecord::Base
  belongs_to :category, -> { order "name" }
  has_many :reviews
  has_many :photos

  validates :name, presence: true
  validates :address, presence: true
  validates :category_id, presence: true
  validates :description, presence: true

  def average_rating
    reviews.average(:rating).round(1) if reviews.average(:rating)
  end
end
