Fabricator(:visited_sight) do
  user_id { Faker::Number.digit }
  sight_id { Faker::Number.digit }
end
