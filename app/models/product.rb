class Product < ApplicationRecord
  belongs_to :product_type

  monetize :price_cents

  # has_attached :photo
end
