class Product < ApplicationRecord
  belongs_to :product_type

  monetize :price_cents

  has_one_attached :photo
end
