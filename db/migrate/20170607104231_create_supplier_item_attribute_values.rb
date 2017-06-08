class CreateSupplierItemAttributeValues < ActiveRecord::Migration[5.1]
  def change
    create_table :supplier_item_attribute_values do |t|
      t.references :item, foreign_key: { to_table: :supplier_items }
      t.references :supplier_attribute, foreign_key: true
      t.boolean :has_duplicates

      t.timestamps
    end

  end
end
