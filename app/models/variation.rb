class Variation < ApplicationRecord
  belongs_to :product

  has_many :variations_gtins
  has_many :variation_photos

  has_one :supplier_item
end
