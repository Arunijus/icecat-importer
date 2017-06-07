class SupplierCategory < ApplicationRecord
  belongs_to :supplier

  has_many :categories, through: :categories_map
end
