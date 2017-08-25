class Product < ApplicationRecord
  paginates_per 50

  belongs_to :family, class_name: 'ProductFamily', foreign_key: "family_id", optional: true
  belongs_to :default_variation, class_name: 'Variation', foreign_key: "default_variation_id", optional: true

  has_many :product_attribute_values
  has_many :product_links
  has_many :assortment
  has_many :variations
  has_many :product_categories
  has_many :categories, through: :product_categories

  def has_description
    self.product_attribute_values.each do |pav|
      if pav.att.special_type === 'description'
        return true
      end
    end

    false
  end

  def description
    self.product_attribute_values.each do |pav|
      if pav.att.special_type === 'description'
        return pav.attribute_value.attribute_value_translations.first.attr_value
      end
    end

    ''
  end

  def supplier_categories
    {}
  end

  def get_why_not_active
    'Because'
  end

  def attribute_values
    av = []
    self.product_attribute_values.each do |pav|
      av << AttributeValue.find(pav.attribute_value.id)
    end
    av
  end
end
