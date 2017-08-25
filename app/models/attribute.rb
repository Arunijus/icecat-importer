class Attribute < ApplicationRecord
  has_many :attribute_translations
  has_many :attribute_values, foreign_key: "attribute_value_id", class_name: "AttributeValue"
  has_many :attribute_value_transformations
  has_many :product_attribute_values

  def is_editable
    true
  end

  def information
    name = self.attribute_translations.first.name
    if self.suffix && self.suffix != ''
      return '#' + self.id.to_s + ' ' + name + ', ' + self.suffix
    end

    '#' + self.id.to_s + ' ' + name
  end
end
