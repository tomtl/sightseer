class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :sight

  validates :image, presence: true, on: :create

  mount_uploader :image, ImageUploader

  def medium_url
    "#{s3_path}medium_#{image_identifier}?"
  end

  def thumb_url
    "#{s3_path}thumb_#{image_identifier}?"
  end

  private

  def s3_path
    "https://#{ENV["S3_BUCKET_NAME"]}.s3.amazonaws.com/uploads/"
  end
end
