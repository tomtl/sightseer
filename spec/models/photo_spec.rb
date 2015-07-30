require "spec_helper"

describe Photo do
  it { should belong_to(:user) }
  it { should belong_to(:sight) }
  it { should validate_presence_of(:image) }
end
