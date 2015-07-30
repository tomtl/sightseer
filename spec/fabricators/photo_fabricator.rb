Fabricator(:photo) do
  image { "files/example.jpg" }
  description { Faker::Lorem.sentences(1) }
end
