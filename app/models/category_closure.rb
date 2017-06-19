class CategoryClosure < ApplicationRecord
  self.table_name = "category_closure"

  belongs_to :ancestor, class_name: 'Category', foreign_key: "ancestor"
  belongs_to :descendant, class_name: 'Category', foreign_key: "descendant"
end
