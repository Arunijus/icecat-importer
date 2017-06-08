class SupplierItemAttributeValue < ApplicationRecord
  belongs_to :supplier_item, class_name: 'SupplierItem', foreign_key: "item_id"
  belongs_to :supplier_attribute
end
