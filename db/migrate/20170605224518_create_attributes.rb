class CreateAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :attributes do |t|
      t.string :special_type
      t.string :suffix
      t.string :value_type
      t.boolean :is_translatable

      t.timestamps
    end
  end
end
