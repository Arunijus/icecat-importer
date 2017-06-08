class AttributeValueTranslation < ApplicationRecord
  self.table_name = "attribute_value_translation"
  belongs_to :attribute_value
end
