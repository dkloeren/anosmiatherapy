class Product < ApplicationRecord
  belongs_to :product_type

  monetize :price_cents
end
