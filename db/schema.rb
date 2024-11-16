# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_11_16_002013) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "beverages", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.boolean "is_alcholic"
    t.integer "calories"
    t.integer "establishment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["establishment_id"], name: "index_beverages_on_establishment_id"
  end

  create_table "beverages_menus", id: false, force: :cascade do |t|
    t.integer "menu_id", null: false
    t.integer "beverage_id", null: false
    t.index ["beverage_id", "menu_id"], name: "index_beverages_menus_on_beverage_id_and_menu_id"
    t.index ["menu_id", "beverage_id"], name: "index_beverages_menus_on_menu_id_and_beverage_id", unique: true
  end

  create_table "dish_tags", force: :cascade do |t|
    t.integer "dish_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_dish_tags_on_dish_id"
    t.index ["tag_id"], name: "index_dish_tags_on_tag_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "calories"
    t.integer "establishment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["establishment_id"], name: "index_dishes_on_establishment_id"
  end

  create_table "dishes_menus", id: false, force: :cascade do |t|
    t.integer "menu_id", null: false
    t.integer "dish_id", null: false
    t.index ["dish_id", "menu_id"], name: "index_dishes_menus_on_dish_id_and_menu_id"
    t.index ["menu_id", "dish_id"], name: "index_dishes_menus_on_menu_id_and_dish_id", unique: true
  end

  create_table "establishments", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "cnpj"
    t.string "address"
    t.string "phone"
    t.string "email"
    t.string "code"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_establishments_on_user_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.integer "establishment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["establishment_id"], name: "index_menus_on_establishment_id"
  end

  create_table "opening_hours", force: :cascade do |t|
    t.integer "establishment_id", null: false
    t.string "day_of_week"
    t.time "open_time"
    t.time "close_time"
    t.boolean "closed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["establishment_id"], name: "index_opening_hours_on_establishment_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "portion_id", null: false
    t.integer "quantity"
    t.text "observation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_name"
    t.integer "unit_price"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["portion_id"], name: "index_order_items_on_portion_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "menu_id", null: false
    t.string "code"
    t.string "costumer_name"
    t.string "costumer_phone"
    t.string "costumer_email"
    t.string "costumer_doc"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "establishment_id", null: false
    t.index ["establishment_id"], name: "index_orders_on_establishment_id"
    t.index ["menu_id"], name: "index_orders_on_menu_id"
  end

  create_table "portion_price_histories", force: :cascade do |t|
    t.integer "portion_id", null: false
    t.integer "price", null: false
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portion_id"], name: "index_portion_price_histories_on_portion_id"
  end

  create_table "portions", force: :cascade do |t|
    t.string "description", null: false
    t.integer "price", null: false
    t.integer "dish_id"
    t.integer "beverage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beverage_id"], name: "index_portions_on_beverage_id"
    t.index ["dish_id"], name: "index_portions_on_dish_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "last_name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "beverages", "establishments"
  add_foreign_key "dish_tags", "dishes"
  add_foreign_key "dish_tags", "tags"
  add_foreign_key "dishes", "establishments"
  add_foreign_key "establishments", "users"
  add_foreign_key "menus", "establishments"
  add_foreign_key "opening_hours", "establishments"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "portions"
  add_foreign_key "orders", "establishments"
  add_foreign_key "orders", "menus"
  add_foreign_key "portion_price_histories", "portions"
  add_foreign_key "portions", "beverages"
  add_foreign_key "portions", "dishes"
end
