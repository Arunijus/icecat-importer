class CategoriesMap < ApplicationRecord
  self.table_name = "categories_map"

  belongs_to :seller_category, class_name: 'Category', foreign_key: "seller_category_id"
  belongs_to :supplier_category
end
