class Assortment < ApplicationRecord
  self.table_name = "assortment"

  belongs_to :product
  belongs_to :shop
end
