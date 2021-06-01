
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

CATEGORIES = %w[fruits spice vegetables]
RATING = [1,2,3,4,5]

10.times do
  #Scent
  category = CATEGORIES.sample
  case category
  when "fruits"
    food = Faker::Food.fruits
  when "spice"
    food = Faker::Food.spice
  when "vegetables"
    food = Faker::Food.vegetables
  end
  Scent.create!(name: food, category: category)
  file = URI.open(Faker::LoremFlickr.image(size: "300x300"))
  # file = URI.open("https://picsum.photos/200/300?random=1")
  Scent.last.photo.attach(io: file, filename: food, content_type: 'image/jpg')
end

10.times do
  # User
  User.create!(first_name: Faker::Name.first_name, last_name:Faker::Name.last_name , email: Faker::Internet.email, password: "111111")
  file = URI.open(Faker::LoremFlickr.image(size: "200x200", search_terms: ['sports']))
  User.last.avatar.attach(io: file, filename: "avatar", content_type: 'image/jpg')

  i = 0
  4.times do
    i += 1
    SmellProgram.create!(scent: Scent.find(i), user: User.last, status: 0)
    SmellEntry.create!(strength_rating: RATING.sample, accuracy_rating: RATING.sample, smell_program: SmellProgram.last)
    SmellEntry.create!(strength_rating: RATING.sample, accuracy_rating: RATING.sample, smell_program: SmellProgram.last)
    SmellEntry.create!(strength_rating: RATING.sample, accuracy_rating: RATING.sample, smell_program: SmellProgram.last)
  end
end

