require "spec_helper"

describe User do
  it { should have_many(:reviews) }
  it { should have_many(:visited_sights) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:full_name) }
  it { should validate_uniqueness_of(:email) }
end
