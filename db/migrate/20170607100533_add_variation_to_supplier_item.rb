class AddVariationToSupplierItem < ActiveRecord::Migration[5.1]
  def change
    add_reference :supplier_items, :variation, foreign_key: true
  end
end
