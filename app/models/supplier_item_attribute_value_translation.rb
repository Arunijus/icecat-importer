class SupplierItemAttributeValueTranslation < ApplicationRecord
  self.table_name = "supplier_item_attribute_value_translation"
  belongs_to :supplier_item_attribute_value
end
