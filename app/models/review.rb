class Review < ActiveRecord::Base
  belongs_to :sight
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  validates :rating, presence: true
end
