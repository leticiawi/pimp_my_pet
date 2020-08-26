class Product < ApplicationRecord
  belongs_to :user
  has_many :carts
  has_one_attached :photo
end
