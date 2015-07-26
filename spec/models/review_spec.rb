require "spec_helper"

describe Review do
  it { should belong_to(:sight) }
  it { should validate_presence_of(:rating) }
end
