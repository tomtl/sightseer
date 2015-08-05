class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :sight

  validates :image, presence: true, on: :create

  mount_uploader :image, ImageUploader
end
