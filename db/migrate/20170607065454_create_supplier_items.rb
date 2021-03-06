class CreateSupplierItems < ActiveRecord::Migration[5.1]
  def change
    create_table :supplier_items do |t|
      t.references :variation, foreign_key: true
      t.string :measurement_unit
      t.string :foreign_id
      t.text :payload, limit: 4294967295
      t.references :supplier_category, foreign_key: true
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
