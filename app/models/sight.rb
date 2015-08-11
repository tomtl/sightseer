class Sight < ActiveRecord::Base
  belongs_to :category, -> { order "name" }
  has_many :reviews
  has_many :photos

  validates :name, presence: true
  validates :address, presence: true
  validates :category_id, presence: true
  validates :description, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def average_rating
    reviews.average(:rating).round(1) if reviews.average(:rating)
  end

  def has_photos?
    !photos.empty?
  end

  def standard_photo
    "#{s3_path}medium_#{photos.first.image_identifier}?" unless photos.empty?
  end

  def standard_thumb
    "#{s3_path}thumb_#{photos.first.image_identifier}?" unless photos.empty?
  end

  private

  def s3_path
    "https://#{ENV["S3_BUCKET_NAME"]}.s3.amazonaws.com/uploads/"
  end
end
