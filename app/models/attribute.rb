class Attribute < ApplicationRecord
  translates :name, touch: true

  has_many :attribute_values, foreign_key: "attribute_value_id", class_name: "AttributeValue"
  has_many :attribute_value_transformations
  has_many :product_attribute_values
end
