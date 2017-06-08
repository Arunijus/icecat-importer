class CreateAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :attributes do |t|
      t.string :type
      t.string :suffix
      t.string :value_type

      t.timestamps
    end
  end
end
