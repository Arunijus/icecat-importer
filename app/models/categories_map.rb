class CategoriesMap < ApplicationRecord
  belongs_to :supplier_category
  belongs_to :category
end
