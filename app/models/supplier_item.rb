class SupplierItem < ApplicationRecord
  # belongs_to :supplier_category
  belongs_to :supplier
  belongs_to :variation

  has_many :supplier_item_attribute_values
end
