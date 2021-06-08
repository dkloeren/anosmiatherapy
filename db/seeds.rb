
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
LASTNAMES   = %w[Administer     Doncic              Jerry                   Mueller                 Robinson                        Shaduw         ABCDEFGHIJKLMNOPQRST]
PASSWORDS   = %w[111111         111111              111111                  111111                  111111                          111111         111111 ]
EMAILS      = %w[admin@mail.com mvp.2021@dallas.com tomhatesjerry@mail.org  priority1@freemail.def  derrobinsonhans@hansepeter.com  elisa@mail.com abcdefghijklmnopqrst@alphabet.com]

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

#xx
# 1 choose a new scent and find an image-link
IMAGES = {
  "orange" => "https://images.unsplash.com/photo-1611178240580-43c2105a7b62?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Njl8fG9yYW5nZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
  "palosanto" => "https://images.unsplash.com/photo-1612088486201-2cb53360306c?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGFsbyUyMHNhbnRvfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
  "cedar" => "https://images.unsplash.com/photo-1615195695780-bb72bdeda718?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=752&q=80",
  "oud" => "https://vcandlesupplies.com/wp-content/uploads/2021/03/Tom-Ford-Oud-Wood-Type-Pure-Fragrance-Oils-FB.jpg",
  "santal" => "https://i.pinimg.com/564x/52/ec/5f/52ec5f0ed9d6fee8fcb6a8ad633e411e.jpg",
  "lavender" => "https://images.unsplash.com/photo-1498998754966-9f72acbc85b2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80",
  "patchouli" => "https://www.gardenmotherherbs.com/wp-content/uploads/2016/06/Patchouli-600x425.jpg",
  "rose" => "https://images.unsplash.com/photo-1574545488652-2a97d6b6c387?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTU5fHxyb3NlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
  "ylang-ylang" => "https://www.seedeo.de/media/image/dc/26/46/970_ylang-ylang_600x600.jpg",
  "black-pepper" => "https://images.unsplash.com/photo-1509358740172-f77c168f6312?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8ZGFyayUyMHBlcHBlcnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
  "ginger" => "https://images.unsplash.com/photo-1599940859674-a7fef05b94ae?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Z2luZ2VyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
  "cinnamon" => "https://images.unsplash.com/photo-1556682313-d298978569db?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=379&q=80",
  "cardamom" => "https://images.unsplash.com/photo-1541533693007-7ea47d894b0c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=376&q=80",
  "thyme" => "https://images.unsplash.com/photo-1570910015265-5da158c809e2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=375&q=80",
  "teatree" => "https://www.thegardener.co.za/wp-content/uploads/2018/01/IMG_0287.jpg",
  "rosemary" => "https://images.unsplash.com/photo-1594313016519-640ed47407ea?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fHJvc2VtYXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
  "sage" => "https://images.unsplash.com/photo-1606841634219-d7dbdd97b1ec?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
  "bergamot" => "https://goddesswitchcraft.com/wp-content/uploads/2019/02/Bergamot-Fruit.jpg",
  "lemon" => "https://images.unsplash.com/photo-1608322368735-b6b6ec262af7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
  "grapefruit" => "https://images.unsplash.com/photo-1557656806-534427e2fe2e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=80",
}

# 2 add a category if the new scent
CATEGORIES = %w[herbal citrus woody floral spicy]

RATING = [1,2,3,4,5]

CATEGORIES.each do |category|
  case category
  when "citrus"
    scents = ["orange", "bergamot", "lemon", "grapefruit"].sample(4)
  when "herbal"
    scents = ["thyme", "rosemary", "sage", "teatree"].sample(4)
  when "woody"
    scents = ["cedar", "palosanto", "oud", "santal"].sample(4)
  when "floral"
    scents = ["lavender", "patchouli", "rose", "ylang-ylang"].sample(4)
  when "spicy"
    scents = ["black-pepper", "ginger", "cinnamon", "cardamom"].sample(4)
  end

  scents.each_with_index do |scent, index|
    puts index
    Scent.create!(name: scent, category: category)
    puts IMAGES[scent]
    # file = URI.open(IMAGES[scent])

    # Scent.last.photo.attach(io: file, filename: scent, content_type: 'image/jpg')

  end
end


################################################################################

INITIAL = [0,1]
CHANGE = [ 0, 0, 0, 1,]

User.all.each do |user|
  Scent.all.sample(8).each_with_index do |scent, index|
    if index < 4
      state = "ready"
    else
      state = "completed"
    end
    SmellProgram.create!(scent: scent, user: user, status: state, image: IMAGES[scent.name])
    strength = INITIAL.sample
    accuracy = INITIAL.sample
    ((index + 1) * 8).times do
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

puts 'Cleaning database...'
Product.destroy_all
ProductType.destroy_all

puts 'Creating categories...'
kit = ProductType.create!(name: 'scent kit')
individual_scent = ProductType.create!(name: 'individual scent')

puts 'Creating products...'
Product.create!(sku: 'scent-kit', name: 'Scent Kit', product_type: kit, price_cents: 3500)
image_url = "https://res.cloudinary.com/dmak3udzc/image/upload/v1623160399/Anosmiatherapy/Product/kit_scent2_hy7tb5.jpg"
file = URI.open(url)
Product.last.photo.attach(io: file, filename: scent, content_type: 'image/jpg')

# Product.create!(sku: 'individual-scent-citrus', name: 'Citrus Scent', product_type: individual_scent, price_cents: 2000)
# image_url = "url"
# file = URI.open(url)
# Product.last.photo.attach(io: file, filename: scent, content_type: 'image/jpg')

# Product.create!(sku: 'individual-scent-wood',   name: 'Wood Scent',   product_type: individual_scent, price_cents: 2000)
# image_url = "url"
# file = URI.open(url)
# Product.last.photo.attach(io: file, filename: scent, content_type: 'image/jpg')

# Product.create!(sku: 'individual-scent-floral',   name: 'Floral Scent',   product_type: individual_scent, price_cents: 2000)
# image_url = "url"
# file = URI.open(url)
# Product.last.photo.attach(io: file, filename: scent, content_type: 'image/jpg')

puts 'Finished!'

#####

QUOTES = {
  "William Shakespeare" => "What's in a name? That which we call a rose by any other name would smell as sweet.",
  "Barbara Streisand" => "I love things that are indescribable, like the taste of an avocado or the smell of a gardenia.",
  "Yotam Ottolenghi" => "I love my garlic press; in fact, it is probably my one true desert island gadget. But I'm happy to put it aside whenever the smell and sweet taste of slow-cooked garlic is called for.",
  "Vladimir Nabokov" => "Nothing revives the past so completely as a smell that was once associated with it.",
  "Leonardo Davinci" => "There are four Powers: memory and intellect, desire and covetousness. The two first are mental and the others sensual. The three senses: sight, hearing and smell cannot well be prevented; touch and taste not at all.",
  "Jennifer Lopez" => "I judge people on how they smell, not how they look.",
  "Cameron Mackintoch" => "An old building is like a show. You smell the soul of a building. And the building tells you how to redo it.",
  "Rihanna" => "I love reading people. I really enjoy watching, observing, and being able to figure out a person, the reason they wore that dress, the reason they smell the way they do.",
  "Friedrich Nietschze" => "Does wisdom perhaps appear on the earth as a raven which is inspired by the smell of carrion?",
  "Sylvia Plath" => "Now and then, when I grow nostalgic about my ocean childhood - the wauling of gulls and the smell of salt, somebody solicitous will bundle me into a car and drive me to the nearest briny horizon.",
  "Haruki Murakami" => "When I write about a 15-year old, I jump, I return to the days when I was that age. It's like a time machine. I can remember everything. I can feel the wind. I can smell the air. Very actually. Very vividly.",
  "Trixie Mattel" => "As a kid, I wasn't allowed to have girl toys, but I would take my cousin's My Little Pony and smell it. That weird, synthetic, fruity-sweet smell - that's how I wanted to look. I wanted to look like this fabricated toy. I wanted to look like you could pull a string on my back, and I would say, like, six catchphrases.",
  "Joan Rivers" => "My eyes opened, and the first thing I thought of when I could put thoughts together was I want to be in show business. Never wanted anything else. I used to sneak in the costume room at my nursery school and smell the costumes.",
  "David Lynch" => "I like watercolours. I like acrylic paint... a little bit. I like house paint. I like oil-based paint, and I love oil paint. I love the smell of turpentine and I like that world of oil paint very, very, very much.",
  "Sophie Dahl" => "When I write about things, it's a lot to do with sense memory. How things smell and taste can bring incredible memories flooding back and transport you in an instant to another time and place.",
}

puts "creating quotes"

QUOTES.each do |author, text|
  Quote.create(author: author, text: text)
end


