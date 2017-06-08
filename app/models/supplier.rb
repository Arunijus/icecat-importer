class Supplier < ApplicationRecord
  has_many :supplier_attributes
  has_many :supplier_items
  has_many :variation_gtins
end
