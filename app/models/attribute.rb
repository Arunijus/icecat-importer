class Attribute < ApplicationRecord
  translates :name, touch: true
has_one :owner, foreign_key: "category_id", class_name: "Transaction"
  has_many :attribute_values_, foreign_key: "attribute_value_id", class_name: "AttributeValue"
  has_many :attribute_value_transformations
  has_many :product_attribute_values
end
