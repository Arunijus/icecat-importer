class CreateProductFamilies < ActiveRecord::Migration[5.1]
  def change
    create_table :product_families do |t|
      t.string :name
      t.boolean :isApproved

      t.timestamps
    end
  end
end
