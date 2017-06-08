class SupplierAttribute < ApplicationRecord

  belongs_to :supplier
  belongs_to :att, class_name: 'Attribute', foreign_key: "attribute_id"
  has_many :supplier_attribute_translations
end
