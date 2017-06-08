class ProductAttributeValue < ApplicationRecord
  belongs_to :att, class_name: 'Attribute', foreign_key: "attribute_id"
  belongs_to :attribute_value
  belongs_to :product
  belongs_to :supplier
end
