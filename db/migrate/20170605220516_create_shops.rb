class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :uuid
      t.string :locale, limit: 10

      t.timestamps
    end
  end
end
