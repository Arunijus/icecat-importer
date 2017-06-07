class Category < ApplicationRecord
  has_many :categories_map
  has_many :product_categories
  has_many :products, through: :product_categories
  has_many :supplier_categories, through: :categories_map
end
