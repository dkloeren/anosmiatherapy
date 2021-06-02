
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

# random seeds

# ID             0              1                   2                       3                       4                               5              6
FIRSTNAMES  = %w[Admin          Luka                Tom                     Hannelore               Hans-Peter                      Elisabeth      ABCDEFGHIJKLMNOPQRST]
LASTNAMES   = %w[Administer     Doncic              Jerry                   Mueller                 Robinson                        Windsor        ABCDEFGHIJKLMNOPQRST]
PASSWORDS   = %w[111111         111111              111111                  111111                  111111                          111111         111111 ]
EMAILS      = %w[admin@mail.com mvp.2021@dallas.com tomhatesjerry@mail.org  priority1@freemail.def  derrobinsonhans@hansepeter.com  me@queen.co.uk abcdefghijklmnopqrst@alphabet.com]

FIRSTNAMES.each_with_index do |firstname, index|
  User.create!(
  first_name: firstname,
  last_name: LASTNAMES[index],
  email: EMAILS[index],
  password: PASSWORDS[index])
end

User.all.each do |user|
  file = URI.open(Faker::LoremFlickr.image(size: "200x200", search_terms: ['sports']))
  user.avatar.attach(io: file, filename: "avatar", content_type: 'image/jpg')
end

################################################################################

# 1 choose a new scent and find an image-link
IMAGES = {
  "apple" => "https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1334&q=80",
  "oak" => "https://images.unsplash.com/photo-1554048692-225e0574d2d6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2850&q=80",
  "lavender" => "https://images.unsplash.com/photo-1498998754966-9f72acbc85b2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80",
  "onion" => "https://images.unsplash.com/photo-1580201092675-a0a6a6cafbb1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80",
  "orange" => "https://images.unsplash.com/photo-1582979512210-99b6a53386f9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80",
}

# 2 add a category if the new scent
CATEGORIES = %w[fruity citrus woody floral spicy]

RATING = [1,2,3,4,5]

CATEGORIES.each do |category|
  case category
  when "citrus"
    scent = ["orange"].sample
  when "fruity"
    scent = ["apple"].sample
  when "woody"
    scent = ["oak"].sample
  when "floral"
    scent = ["lavender"].sample
  when "spicy"
    scent = ["onion"].sample
  end
  Scent.create!(name: scent, category: category)
  file = URI.open(IMAGES[scent])
  Scent.last.photo.attach(io: file, filename: scent, content_type: 'image/jpg')
end


################################################################################

INITIAL = [0,1]
CHANGE = [ 0, 0, 0, 1, 1]

User.all.each do |user|
  Scent.all.each do |scent|
    SmellProgram.create!(scent: scent, user: user, status: 0)
    strength = INITIAL.sample
    accuracy = INITIAL.sample
    10.times do
      strength += CHANGE.sample  if strength < 5
      accuracy += CHANGE.sample  if accuracy < 5
      if strength + accuracy < 10
        SmellEntry.create!(strength_rating: strength, accuracy_rating: accuracy, smell_program: SmellProgram.last)
      else
        SmellProgram.last.status = 1
        SmellProgram.last.save
      end
    end
  end
end



#####
