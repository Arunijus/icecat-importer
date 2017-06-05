class CreateProductFamilyAttributeGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :product_family_attribute_groups do |t|
      t.string :name
      t.string :uuid
      t.integer :position
      t.references :family, foreign_key: { to_table: :product_families }

      t.timestamps
    end
  end
end
