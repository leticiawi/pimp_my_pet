class Product < ApplicationRecord
  belongs_to :user
  has_many :carts
  has_many :orders
  has_one_attached :photo

  monetize :price_cents
end
