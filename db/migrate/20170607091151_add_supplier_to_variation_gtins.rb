class AddSupplierToVariationGtins < ActiveRecord::Migration[5.1]
  def change
    add_reference :variation_gtins, :supplier, foreign_key: true
  end
end
