class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
  validates :password, presence: true, on: :create, length: { minimum: 4 }

  has_secure_password
end
