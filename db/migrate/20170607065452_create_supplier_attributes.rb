class CreateSupplierAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :supplier_attributes do |t|
      t.text :foreign_id, limit: 255
      t.references :supplier, foreign_key: true
      t.references :attribute, foreign_key: true

      t.timestamps
    end

    create_table :supplier_attribute_translation do |t|
      t.references :translatable, foreign_key: { to_table: :supplier_attributes }
      t.string :locale
      t.string :name
    end
  end
end
