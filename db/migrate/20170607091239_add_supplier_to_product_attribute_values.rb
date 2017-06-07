class AddSupplierToProductAttributeValues < ActiveRecord::Migration[5.1]
  def change
    add_reference :product_attribute_values, :supplier, foreign_key: true
  end
end
