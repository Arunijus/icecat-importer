class CreateSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers do |t|
      t.text :name, limit: 255
      t.text :import_identifier, limit: 255

      t.timestamps
    end
  end
end
