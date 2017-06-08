class AttributeValue < ApplicationRecord
  belongs_to :att, class_name: 'Attribute', foreign_key: "attribute_id"

  has_many :product_attribute_values
  has_many :attribute_value_translations
end
