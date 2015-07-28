class Photo < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  mount_uploader :thumbnail, ThumbnailUploader
end