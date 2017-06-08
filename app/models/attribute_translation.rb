class AttributeTranslation < ApplicationRecord
  self.table_name = "attribute_translation"
  belongs_to :attribute
end
