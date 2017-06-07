class SupplierItemAttributeValue < ApplicationRecord
  translates :value, :transformed_value, :last_checked_value, touch: true

  belongs_to :item
  belongs_to :supplier_attribute
end
