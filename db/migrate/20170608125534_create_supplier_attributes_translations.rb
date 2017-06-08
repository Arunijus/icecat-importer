class CreateSupplierAttributesTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :supplier_attribute_translation do |t|
      t.references :supplier_attributes, foreign_key: true
      t.string :locale
      t.string :name

      t.timestamps
    end
  end
end
