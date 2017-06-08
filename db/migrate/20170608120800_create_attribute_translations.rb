class CreateAttributeTranslations < ActiveRecord::Migration[5.1]
  def change
    create_table :attribute_translations do |t|
      t.references :attribute, foreign_key: true
      t.string :name
      t.string :locale

      t.timestamps
    end
  end
end
