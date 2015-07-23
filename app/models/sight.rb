class Sight < ActiveRecord::Base
  validates :name, presence: true
  validates :address, presence: true
  validates :category_id, presence: true
  validates :description, presence: true

  belongs_to :category, -> { order "name" }
end