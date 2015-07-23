class Category < ActiveRecord::Base
  has_many :sights

  validates :name, presence: true
end
