class AttributeValue < ApplicationRecord
  belongs_to :attribute

  has_many :product_attribute_values
end
