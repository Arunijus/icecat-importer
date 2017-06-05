class CreateProductFamilyAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :product_family_attributes do |t|
      t.references :attribute, foreign_key: true
      t.references :family, foreign_key: { to_table: :product_families }
      t.integer :position
      t.references :group, foreign_key: { to_table: :product_family_attribute_groups }
      t.string :type
      t.boolean :required
      t.boolean :indexed
      t.boolean :filtered

      t.timestamps
    end
  end
end
