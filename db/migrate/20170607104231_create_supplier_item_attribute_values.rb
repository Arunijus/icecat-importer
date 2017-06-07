class CreateSupplierItemAttributeValues < ActiveRecord::Migration[5.1]
  def change
    create_table :supplier_item_attribute_values do |t|
      t.references :item, foreign_key: { to_table: :supplier_items }
      t.references :supplier_attribute, foreign_key: true
      t.boolean :has_duplicates

      t.timestamps
    end

    create_table :supplier_item_attribute_value_translation do |t|
      t.references :translatable, foreign_key: { to_table: :supplier_item_attribute_values }, index: {:name => "index_siavt_on_translatable_id"}
      t.string :locale
      t.text :value
      t.text :transformed_value
      t.text :last_checked_value
    end
  end
end
