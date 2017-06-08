class AttributeValue < ApplicationRecord
  translates :attr_value, :status, :hash, touch: true

  belongs_to :att, class_name: 'Attribute', foreign_key: "attribute_id"

  has_many :product_attribute_values
end
