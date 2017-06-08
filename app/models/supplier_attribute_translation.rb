class SupplierAttributesTranslation < ApplicationRecord
  self.table_name = "supplier_attribute_translation"
  belongs_to :supplier_attributes
end
