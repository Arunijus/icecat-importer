class ProductFamilyAttribute < ApplicationRecord
  belongs_to :attribute
  belongs_to :family
  belongs_to :group
end
