class Category < ApplicationRecord
  has_many :categories_map
  has_many :category_closure
  has_many :product_categories
  has_many :products, through: :product_categories
  has_many :supplier_categories, through: :categories_map

  # Not full. Used for testing.
  def full_path_name(separator)
    if self.parent_id
      parent = Category.find(self.parent_id)
      return self.name + separator + parent.name
    end

    self.name
  end
end
