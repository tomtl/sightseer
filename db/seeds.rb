# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
category_names = [
  "Museums",
  "Mouments",
  "Buildings and Architecture",
  "Theme parks",
  "Parks and nature",
  "Markets",
  "Religious",
  "Historical"
]

category_names.each do |category_name|
  Category.create(name: category_name)
end
