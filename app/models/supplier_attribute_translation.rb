class SupplierAttributeTranslation < ApplicationRecord
  self.table_name = "supplier_attribute_translation"
  belongs_to :supplier_attribute
end
