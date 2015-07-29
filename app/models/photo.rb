class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :sight

  validates :image, presence: true

  mount_uploader :image, ImageUploader
end