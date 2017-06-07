class ProductFamily < ApplicationRecord
  has_many :product_family_attribute_groups
  has_many :products
end
