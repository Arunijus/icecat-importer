class SupplierItemAttributeValue < ApplicationRecord

  belongs_to :item
  belongs_to :supplier_attribute
end
