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

ActiveRecord::Schema.define(version: 2021_10_10_221231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "category_id", null: false
    t.index ["category_id", "product_id"], name: "category_to_product_index"
    t.index ["product_id", "category_id"], name: "product_to_category_index"
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

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.integer "rating"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_comments_on_product_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.string "user_type", null: false
    t.bigint "user_id", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id"], name: "index_likes_on_record_type_and_record_id"
    t.index ["user_type", "user_id"], name: "index_likes_on_user_type_and_user_id"
  end

  create_table "order_card_infos", force: :cascade do |t|
    t.string "card_number"
    t.string "expired_date"
    t.string "card_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_user_info_id"
    t.index ["order_user_info_id"], name: "index_order_card_infos_on_order_user_info_id"
  end

  create_table "order_user_infos", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "company"
    t.string "country"
    t.string "address"
    t.string "city"
    t.string "zip_code"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "total"
    t.string "note"
    t.bigint "user_id", null: false
    t.bigint "order_user_info_id"
    t.index ["order_user_info_id"], name: "index_orders_on_order_user_info_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "product_advanceds", force: :cascade do |t|
    t.text "purchase_note"
    t.boolean "enable_reviews"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_meta_id", null: false
    t.index ["product_meta_id"], name: "index_product_advanceds_on_product_meta_id"
  end

  create_table "product_attributes_names", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_product_attributes_names_on_name", unique: true
  end

  create_table "product_attributes_values", force: :cascade do |t|
    t.bigint "product_attributes_name_id", null: false
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_attributes_name_id"], name: "index_product_attributes_values_on_product_attributes_name_id"
  end

  create_table "product_attributes_values_variations", id: false, force: :cascade do |t|
    t.bigint "product_variation_id", null: false
    t.bigint "product_attributes_value_id", null: false
    t.index ["product_attributes_value_id", "product_variation_id"], name: "attrs_value_to_product_variation"
    t.index ["product_variation_id", "product_attributes_value_id"], name: "variation_to_attrs_value"
  end

  create_table "product_carts", force: :cascade do |t|
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "product_cart_container_type"
    t.bigint "product_cart_container_id"
    t.string "product_type"
    t.bigint "product_id"
    t.index ["product_type", "product_id"], name: "index_product_carts_on_product_type_and_product_id"
  end

  create_table "product_cross_sells", id: false, force: :cascade do |t|
    t.integer "product_linked_id", null: false
    t.integer "product_cross_sell_id", null: false
    t.index ["product_linked_id", "product_cross_sell_id"], name: "product_cross_sell_index"
  end

  create_table "product_details", force: :cascade do |t|
    t.bigint "product_meta_id", null: false
    t.decimal "regular_price"
    t.text "description"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_meta_id"], name: "index_product_details_on_product_meta_id"
  end

  create_table "product_extras", force: :cascade do |t|
    t.text "product_video"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_meta_id", null: false
    t.string "tag"
    t.index ["product_meta_id"], name: "index_product_extras_on_product_meta_id"
  end

  create_table "product_inventories", force: :cascade do |t|
    t.text "sku"
    t.text "stock_status"
    t.boolean "manage_stock"
    t.boolean "sold_individually"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_meta_id", null: false
    t.index ["product_meta_id"], name: "index_product_inventories_on_product_meta_id"
  end

  create_table "product_linkeds", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_meta_id", null: false
    t.index ["product_meta_id"], name: "index_product_linkeds_on_product_meta_id"
  end

  create_table "product_meta", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "images"
    t.string "product_type"
    t.bigint "product_id"
    t.index ["product_type", "product_id"], name: "index_product_meta_on_product_type_and_product_id"
  end

  create_table "product_reviews", force: :cascade do |t|
    t.integer "ratings"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_meta_id", null: false
    t.index ["product_meta_id"], name: "index_product_reviews_on_product_meta_id"
  end

  create_table "product_sale_prices", force: :cascade do |t|
    t.decimal "sale_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_meta_id", null: false
    t.datetime "sale_date_start"
    t.datetime "sale_date_end"
    t.index ["product_meta_id"], name: "index_product_sale_prices_on_product_meta_id"
  end

  create_table "product_shippings", force: :cascade do |t|
    t.decimal "weight"
    t.decimal "length"
    t.decimal "width"
    t.decimal "height"
    t.text "shipping_class"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_meta_id", null: false
    t.index ["product_meta_id"], name: "index_product_shippings_on_product_meta_id"
  end

  create_table "product_stocks", force: :cascade do |t|
    t.integer "quantity"
    t.text "in_stock"
    t.bigint "product_meta_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_meta_id"], name: "index_product_stocks_on_product_meta_id"
  end

  create_table "product_upsells", id: false, force: :cascade do |t|
    t.integer "product_linked_id", null: false
    t.integer "product_upsell_id", null: false
    t.index ["product_linked_id", "product_upsell_id"], name: "product_upsell_index"
  end

  create_table "product_variations", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "product_id", null: false
    t.index ["product_id"], name: "index_product_variations_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "replies", force: :cascade do |t|
    t.bigint "comment_id", null: false
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["comment_id"], name: "index_replies_on_comment_id"
    t.index ["user_id"], name: "index_replies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "comments", "products"
  add_foreign_key "comments", "users"
  add_foreign_key "order_card_infos", "order_user_infos"
  add_foreign_key "orders", "users"
  add_foreign_key "product_advanceds", "product_meta", column: "product_meta_id"
  add_foreign_key "product_attributes_values", "product_attributes_names"
  add_foreign_key "product_details", "product_meta", column: "product_meta_id"
  add_foreign_key "product_extras", "product_meta", column: "product_meta_id"
  add_foreign_key "product_inventories", "product_meta", column: "product_meta_id"
  add_foreign_key "product_linkeds", "product_meta", column: "product_meta_id"
  add_foreign_key "product_reviews", "product_meta", column: "product_meta_id"
  add_foreign_key "product_sale_prices", "product_meta", column: "product_meta_id"
  add_foreign_key "product_shippings", "product_meta", column: "product_meta_id"
  add_foreign_key "product_stocks", "product_meta", column: "product_meta_id"
  add_foreign_key "product_variations", "products"
  add_foreign_key "replies", "comments"
  add_foreign_key "replies", "users"
  add_foreign_key "wishlists", "users"
end
