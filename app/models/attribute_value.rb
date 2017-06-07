class AttributeValue < ApplicationRecord
  translates :attr_value, :status, :hash, touch: true

  belongs_to :attribute

  has_many :product_attribute_values
end
