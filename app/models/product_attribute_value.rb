class ProductAttributeValue < ApplicationRecord
  belongs_to :attribute
  belongs_to :attribute_value
  belongs_to :product
end
