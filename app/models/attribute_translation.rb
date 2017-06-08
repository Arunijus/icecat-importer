class AttributeTranslation < ApplicationRecord
  self.table_name = "attribute_translation"

  belongs_to :attr, class_name: 'Attribute', foreign_key: "attribute_id"
end
