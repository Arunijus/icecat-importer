class Product < ApplicationRecord
  belongs_to :family, class_name: 'ProductFamily', foreign_key: "family_id"

  has_many :product_attribute_values
  has_many :product_links
  has_many :assortment
  has_many :variations
  has_many :product_categories
  has_many :categories, through: :product_categories
end
