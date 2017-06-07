class Product < ApplicationRecord
  has_many :product_attribute_values
  has_many :product_links
  has_many :assortment
  has_many :variations
  has_many :product_categories
  has_many :categories, through: :product_categories
end
