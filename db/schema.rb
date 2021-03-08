# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_08_001907) do

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "user_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "country"
    t.string "address"
    t.string "city"
    t.integer "zip_code"
    t.string "phone"
    t.string "email"
    t.string "card_number"
    t.decimal "total"
    t.string "note"
    t.string "expiry_date"
    t.string "card_code"
  end

  create_table "product_advanceds", force: :cascade do |t|
    t.text "purchase_note"
    t.boolean "enable_reviews"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_meta_id", null: false
    t.index ["product_meta_id"], name: "index_product_advanceds_on_product_meta_id"
  end

  create_table "product_attributes", force: :cascade do |t|
    t.text "name"
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_carts", force: :cascade do |t|
    t.string "style"
    t.string "quality"
    t.string "color"
    t.integer "quantity"
    t.string "size"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "cart_id"
    t.integer "product_id"
    t.integer "wishlist_id"
    t.integer "order_id"
    t.index ["cart_id"], name: "index_product_carts_on_cart_id"
    t.index ["order_id"], name: "index_product_carts_on_order_id"
    t.index ["product_id"], name: "index_product_carts_on_product_id"
    t.index ["wishlist_id"], name: "index_product_carts_on_wishlist_id"
  end

  create_table "product_extras", force: :cascade do |t|
    t.text "product_video"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_meta_id", null: false
    t.index ["product_meta_id"], name: "index_product_extras_on_product_meta_id"
  end

  create_table "product_inventories", force: :cascade do |t|
    t.text "sku"
    t.text "stock_status"
    t.boolean "manage_stock"
    t.boolean "sold_individually"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_meta_id", null: false
    t.index ["product_meta_id"], name: "index_product_inventories_on_product_meta_id"
  end

  create_table "product_linkeds", force: :cascade do |t|
    t.text "upsells"
    t.text "cross_sells"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_meta_id", null: false
    t.index ["product_meta_id"], name: "index_product_linkeds_on_product_meta_id"
  end

  create_table "product_meta", force: :cascade do |t|
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "regular_price"
    t.string "tag"
    t.text "description"
    t.text "images"
    t.text "name"
    t.index ["product_id"], name: "index_product_meta_on_product_id"
  end

  create_table "product_reviews", force: :cascade do |t|
    t.integer "ratings"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_sale_prices", force: :cascade do |t|
    t.decimal "sale_price"
    t.decimal "sale_date_start"
    t.decimal "sale_date_end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_shippings", force: :cascade do |t|
    t.decimal "weight"
    t.decimal "length"
    t.decimal "width"
    t.decimal "height"
    t.text "shipping_class"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_meta_id", null: false
    t.index ["product_meta_id"], name: "index_product_shippings_on_product_meta_id"
  end

  create_table "product_stocks", force: :cascade do |t|
    t.integer "quantity"
    t.text "in_stock"
    t.integer "product_meta_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_meta_id"], name: "index_product_stocks_on_product_meta_id"
  end

  create_table "product_variations", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_id", null: false
    t.integer "product_meta_id", null: false
    t.index ["product_id"], name: "index_product_variations_on_product_id"
    t.index ["product_meta_id"], name: "index_product_variations_on_product_meta_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "product_advanceds", "product_meta", column: "product_meta_id"
  add_foreign_key "product_extras", "product_meta", column: "product_meta_id"
  add_foreign_key "product_inventories", "product_meta", column: "product_meta_id"
  add_foreign_key "product_linkeds", "product_meta", column: "product_meta_id"
  add_foreign_key "product_meta", "products"
  add_foreign_key "product_shippings", "product_meta", column: "product_meta_id"
  add_foreign_key "product_stocks", "product_meta", column: "product_meta_id"
  add_foreign_key "product_variations", "product_meta", column: "product_meta_id"
  add_foreign_key "product_variations", "products"
  add_foreign_key "wishlists", "users"
end
