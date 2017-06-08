class Attribute < ApplicationRecord
  has_many :attribute_translations
  has_many :attribute_values, foreign_key: "attribute_value_id", class_name: "AttributeValue"
  has_many :attribute_value_transformations
  has_many :product_attribute_values
end
