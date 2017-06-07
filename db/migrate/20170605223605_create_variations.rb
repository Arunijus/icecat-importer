class CreateVariations < ActiveRecord::Migration[5.1]
  def change
    create_table :variations do |t|
      t.integer :position
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
