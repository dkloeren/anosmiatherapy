
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

  scents.each do |scent|
    Scent.create!(name: scent, category: category)
    file = URI.open(IMAGES[scent])
    Scent.last.photo.attach(io: file, filename: scent, content_type: 'image/jpg')
  end
end


################################################################################

INITIAL = [0,1]
CHANGE = [ 0, 0, 0, 1, 1]

User.all.each do |user|
  Scent.all.sample(8).each_with_index do |scent, index|
    if index < 4
      state = "ready"
    else
      state = "completed"
    end
    SmellProgram.create!(scent: scent, user: user, status: state)
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
