
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
  user = User.create!(first_name: Faker::Name.first_name, last_name:Faker::Name.last_name , email: Faker::Internet.email, password: 111111)
  scent = Scent.create!(name: Faker::Coffee.blend_name, category: Faker::Coffee.origin)
  smell_program = SmellProgram.create!(scent: scent, user: user, status: [1,2,3].sample)
  SmellEntry.create!(strength_rating: RATING.sample, accuracy_rating: RATING.sample, smell_program: smell_program)
  SmellEntry.create!(strength_rating: RATING.sample, accuracy_rating: RATING.sample, smell_program: smell_program)
end
