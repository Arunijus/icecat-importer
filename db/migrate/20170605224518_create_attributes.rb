class CreateAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :attributes do |t|
      t.string :type
      t.string :suffix
      t.string :value_type

      t.timestamps
    end

    create_table :attribute_translation do |t|
      t.references :translatable, foreign_key: { to_table: :attributes }
      t.string :locale
      t.string :name
    end
  end
end
