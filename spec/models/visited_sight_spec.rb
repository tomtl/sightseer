require "spec_helper"

describe VisitedSight do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:sight_id) }
  it { should validate_uniqueness_of(:sight_id) }
  it { should belong_to(:user) }
  it { should belong_to(:sight) }
end
