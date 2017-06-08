class CreateAttributeValueTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :attribute_value_translation do |t|
      t.references :attribute_value, foreign_key: true
      t.text :attr_value
      t.string :status
      t.string :hash
      t.string :locale

      t.timestamps
    end
  end
end
