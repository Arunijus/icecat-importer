class CreateSupplierItems < ActiveRecord::Migration[5.1]
  def change
    create_table :supplier_items do |t|
      t.integer :variation_id
      t.text :measurment_unit, limit: 255
      t.text :payload, limit: 65535
      t.references :supplier_category, foreign_key: true
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
