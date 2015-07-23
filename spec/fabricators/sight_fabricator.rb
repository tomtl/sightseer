Fabricator(:sight) do
  name { Faker::Lorem.word }
  address "Statue of Liberty, NY, USA"
  category_id 1
  description { Faker::Lorem.sentence(2) }
end
