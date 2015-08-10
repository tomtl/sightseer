class User < ActiveRecord::Base
  has_many :reviews
  has_many :visited_sights
  has_many :photos

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password, presence: true, length: { minimum: 4 }

  has_secure_password

  def sight_review(sight)
    reviews.find_by(sight_id: sight.id)
  end

  def reviewed_sight?(sight)
    !!sight_review(sight)
  end

  def generate_token!
    update_column(:token, SecureRandom.urlsafe_base64)
  end

  def delete_token!
    update_column(:token, nil)
  end

  def has_reviews?
    !reviews.empty?
  end

  def has_visited_sights?
    !visited_sights.empty?
  end

  def has_photos?
    !photos.empty?
  end
end
