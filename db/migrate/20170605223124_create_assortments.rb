class CreateAssortments < ActiveRecord::Migration[5.1]
  def change
    create_table :assortment, :id => false do |t|
      t.boolean :is_active
      t.string :status
      t.references :product, foreign_key: true
      t.references :shop, foreign_key: true

      t.timestamps
    end
  end
end
