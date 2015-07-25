Fabricator(:review) do
  user_id { Fabricate(:user).id }
  sight_id { Fabricate(:sight).id }
  rating  { [1,2,3,4,5].sample }
  content { Faker::Lorem.sentence(2) }
end
