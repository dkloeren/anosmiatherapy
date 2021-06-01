
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
CATEGORIES = %w[fruity spicy etheral]
RATING = [1,2,3,4,5]

10.times do
  User.create!(first_name: Faker::Name.first_name, last_name:Faker::Name.last_name , email: Faker::Internet.email, password: "111111")
  Scent.create!(name: Faker::Coffee.blend_name, category: Faker::Coffee.origin)
  SmellProgram.create!(scent: Scent.last, user: User.last, status: [1,2,3].sample)
  SmellEntry.create!(strength_rating: RATING.sample, accuracy_rating: RATING.sample, smell_program: SmellProgram.last)
  SmellEntry.create!(strength_rating: RATING.sample, accuracy_rating: RATING.sample, smell_program: SmellProgram.last)
end
