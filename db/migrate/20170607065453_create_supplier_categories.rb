class CreateSupplierCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :supplier_categories do |t|
      t.integer :parent_id
      t.text :name, limit: 255
      t.text :foreign_id, limit: 255
      t.integer :lft
      t.integer :lvl
      t.integer :rgt
      t.integer :root
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
