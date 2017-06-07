class SupplierItem < ApplicationRecord
  belongs_to :supplier_category
  belongs_to :supplier
end
