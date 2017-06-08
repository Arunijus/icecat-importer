class CreateSupplierItemAttributeValuesTranslations < ActiveRecord::Migration[5.1]
  def change
      create_table :supplier_item_attribute_values_translations do |t|
      t.references :supplier_item_attribute_values, foreign_key: true,  index: {name: 'index_name'}
      t.string :locale
      t.string :value

      t.timestamps
    end
  end
end
