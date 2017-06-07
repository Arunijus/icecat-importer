# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170607131757) do

  create_table "assortment", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.boolean "is_active"
    t.string "status"
    t.bigint "product_id"
    t.bigint "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_assortment_on_product_id"
    t.index ["shop_id"], name: "index_assortment_on_shop_id"
  end

  create_table "attribute_translations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.integer "attribute_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["attribute_id"], name: "index_attribute_translations_on_attribute_id"
    t.index ["locale"], name: "index_attribute_translations_on_locale"
  end

  create_table "attribute_value_transformations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.bigint "attribute_id"
    t.text "from_value"
    t.text "to_value"
    t.boolean "is_enabled"
    t.string "locale", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attribute_id"], name: "index_attribute_value_transformations_on_attribute_id"
  end

  create_table "attribute_values", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.bigint "attribute_id"
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["attribute_id"], name: "index_attribute_values_on_attribute_id"
  end

  create_table "attributes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.string "type"
    t.string "suffix"
    t.string "value_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.integer "parent_id"
    t.text "name", limit: 255
    t.boolean "is_visible"
    t.text "foreign_id", limit: 255
    t.text "slug"
    t.integer "depth"
    t.text "identifier", limit: 255
    t.integer "priority"
    t.text "description"
    t.text "display_rule", limit: 255
    t.integer "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
  end

  create_table "categories_map", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.bigint "supplier_category_id"
    t.bigint "seller_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["seller_category_id"], name: "index_categories_map_on_seller_category_id"
    t.index ["supplier_category_id"], name: "index_categories_map_on_supplier_category_id"
  end

  create_table "product_attribute_values", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.bigint "attribute_id"
    t.bigint "attribute_value_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "supplier_id"
    t.index ["attribute_id"], name: "index_product_attribute_values_on_attribute_id"
    t.index ["attribute_value_id"], name: "index_product_attribute_values_on_attribute_value_id"
    t.index ["product_id"], name: "index_product_attribute_values_on_product_id"
    t.index ["supplier_id"], name: "index_product_attribute_values_on_supplier_id"
  end

  create_table "product_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.bigint "product_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_product_categories_on_category_id"
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "product_families", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.string "name"
    t.string "uuid"
    t.boolean "is_approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_family_attribute_groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.string "name"
    t.string "uuid"
    t.integer "position"
    t.bigint "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_product_family_attribute_groups_on_family_id"
  end

  create_table "product_family_attributes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.bigint "attribute_id"
    t.bigint "family_id"
    t.integer "position"
    t.bigint "group_id"
    t.string "type"
    t.boolean "required"
    t.boolean "indexed"
    t.boolean "filtered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["attribute_id"], name: "index_product_family_attributes_on_attribute_id"
    t.index ["family_id"], name: "index_product_family_attributes_on_family_id"
    t.index ["group_id"], name: "index_product_family_attributes_on_group_id"
  end

  create_table "product_links", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.bigint "product_id"
    t.string "title"
    t.string "url"
    t.string "resource_id"
    t.string "type", limit: 50
    t.boolean "is_active"
    t.integer "position"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_links_on_product_id"
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.string "uuid"
    t.text "note"
    t.datetime "exported_at"
    t.integer "default_variation_id"
    t.bigint "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_products_on_family_id"
  end

  create_table "shops", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.string "name"
    t.string "uuid"
    t.string "locale", limit: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplier_attributes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.text "foreign_id", limit: 255
    t.bigint "supplier_id"
    t.bigint "attribute_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attribute_id"], name: "index_supplier_attributes_on_attribute_id"
    t.index ["supplier_id"], name: "index_supplier_attributes_on_supplier_id"
  end

  create_table "supplier_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.integer "parent_id"
    t.text "name", limit: 255
    t.text "foreign_id", limit: 255
    t.integer "lft"
    t.integer "lvl"
    t.integer "rgt"
    t.integer "root"
    t.bigint "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_supplier_categories_on_supplier_id"
  end

  create_table "supplier_item_attribute_value_translation", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.bigint "translatable_id"
    t.string "locale"
    t.text "value"
    t.text "transformed_value"
    t.text "last_checked_value"
    t.index ["translatable_id"], name: "index_siavt_on_translatable_id"
  end

  create_table "supplier_item_attribute_values", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.bigint "item_id"
    t.bigint "supplier_attribute_id"
    t.boolean "has_duplicates"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_supplier_item_attribute_values_on_item_id"
    t.index ["supplier_attribute_id"], name: "index_supplier_item_attribute_values_on_supplier_attribute_id"
  end

  create_table "supplier_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.text "measurment_unit", limit: 255
    t.text "payload"
    t.bigint "supplier_category_id"
    t.bigint "supplier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "variation_id"
    t.index ["supplier_category_id"], name: "index_supplier_items_on_supplier_category_id"
    t.index ["supplier_id"], name: "index_supplier_items_on_supplier_id"
    t.index ["variation_id"], name: "index_supplier_items_on_variation_id"
  end

  create_table "suppliers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.text "name", limit: 255
    t.text "import_identifier", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "variation_gtins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.string "value"
    t.bigint "variation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "supplier_id"
    t.index ["supplier_id"], name: "index_variation_gtins_on_supplier_id"
    t.index ["variation_id"], name: "index_variation_gtins_on_variation_id"
  end

  create_table "variation_photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.bigint "variation_id"
    t.string "file"
    t.integer "position"
    t.datetime "deleted_at"
    t.string "status", limit: 20
    t.string "checksum", limit: 40
    t.string "source", limit: 100
    t.integer "width"
    t.integer "height"
    t.float "size", limit: 24
    t.float "quality", limit: 24
    t.integer "supplier_priority"
    t.string "master_file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["variation_id"], name: "index_variation_photos_on_variation_id"
  end

  create_table "variations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci" do |t|
    t.integer "position"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.index ["product_id"], name: "index_variations_on_product_id"
  end

  add_foreign_key "assortment", "products"
  add_foreign_key "assortment", "shops"
  add_foreign_key "attribute_value_transformations", "attributes"
  add_foreign_key "attribute_values", "attributes"
  add_foreign_key "categories_map", "categories", column: "seller_category_id"
  add_foreign_key "categories_map", "supplier_categories"
  add_foreign_key "product_attribute_values", "attribute_values"
  add_foreign_key "product_attribute_values", "attributes"
  add_foreign_key "product_attribute_values", "products"
  add_foreign_key "product_attribute_values", "suppliers"
  add_foreign_key "product_categories", "categories"
  add_foreign_key "product_categories", "products"
  add_foreign_key "product_family_attribute_groups", "product_families", column: "family_id"
  add_foreign_key "product_family_attributes", "attributes"
  add_foreign_key "product_family_attributes", "product_families", column: "family_id"
  add_foreign_key "product_family_attributes", "product_family_attribute_groups", column: "group_id"
  add_foreign_key "product_links", "products"
  add_foreign_key "products", "product_families", column: "family_id"
  add_foreign_key "supplier_attributes", "attributes"
  add_foreign_key "supplier_attributes", "suppliers"
  add_foreign_key "supplier_categories", "suppliers"
  add_foreign_key "supplier_item_attribute_value_translation", "supplier_item_attribute_values", column: "translatable_id"
  add_foreign_key "supplier_item_attribute_values", "supplier_attributes"
  add_foreign_key "supplier_item_attribute_values", "supplier_items", column: "item_id"
  add_foreign_key "supplier_items", "supplier_categories"
  add_foreign_key "supplier_items", "suppliers"
  add_foreign_key "supplier_items", "variations"
  add_foreign_key "variation_gtins", "suppliers"
  add_foreign_key "variation_gtins", "variations"
  add_foreign_key "variation_photos", "variations"
  add_foreign_key "variations", "products"
end
