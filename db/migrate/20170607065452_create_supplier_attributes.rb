class CreateSupplierAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :supplier_attributes do |t|
      t.string :foreign_id
      t.integer :primary_attribute_id
      t.references :supplier, foreign_key: true
      t.references :attribute, foreign_key: true

      t.timestamps
    end

  end
end
