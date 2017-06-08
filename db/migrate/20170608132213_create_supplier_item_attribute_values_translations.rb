class CreateSupplierItemAttributeValuesTranslations < ActiveRecord::Migration[5.1]
  def change
      create_table :supplier_item_attribute_value_translation do |t|
      t.references :supplier_item_attribute_value, foreign_key: true,  index: {name: 'index_name'}
      t.string :locale
      t.text :value
      t.text :transformed_value
      t.text :last_checked_value

      t.timestamps
    end
  end
end
