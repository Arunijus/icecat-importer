class SupplierAttribute < ApplicationRecord
  translates :name, touch: true

  belongs_to :supplier
  belongs_to :attribute
end
