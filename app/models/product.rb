class Product < ApplicationRecord
  belongs_to :family

  has_many :product_attribute_values
  has_many :product_links
  has_many :assortment
  has_many :variations
end
