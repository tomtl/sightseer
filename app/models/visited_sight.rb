class VisitedSight < ActiveRecord::Base
  belongs_to :user
  belongs_to :sight

  validates :user_id, presence: true
  validates :sight_id, presence: true
  validates_uniqueness_of :sight_id, scope: :user_id
end
