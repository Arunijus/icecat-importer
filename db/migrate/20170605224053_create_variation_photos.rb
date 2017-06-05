class CreateVariationPhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :variation_photos do |t|
      t.references :variation, foreign_key: true
      t.string :file
      t.integer :position
      t.datetime :deleted_at
      t.string :status, limit: 20
      t.string :checksum, limit: 40
      t.string :source, limit: 100
      t.integer :width
      t.integer :height
      t.float :size
      t.float :quality
      t.integer :supplier_priority
      t.string :master_file

      t.timestamps
    end
  end
end
