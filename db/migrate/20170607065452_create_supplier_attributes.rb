class CreateSupplierAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :supplier_attributes do |t|
      t.text :foreign_id, limit: 255
      t.references :supplier, foreign_key: true
      t.references :attribute, foreign_key: true

      t.timestamps
    end

  end
end
