require "spec_helper"

describe Sight do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:category_id) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:category) }
end
