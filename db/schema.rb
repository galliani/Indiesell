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

ActiveRecord::Schema.define(version: 2020_11_25_051854) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "links", force: :cascade do |t|
    t.integer "purchase_id"
    t.text "blob_signed_id"
    t.text "filename"
    t.string "content_type"
    t.integer "download_size", limit: 8
    t.text "url"
    t.datetime "expiry"
    t.integer "download_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["purchase_id"], name: "index_links_on_purchase_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price_cents", limit: 8, default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.boolean "is_live", default: false
    t.string "serial_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "product_id"
    t.string "serial_number"
    t.boolean "is_paid", default: false
    t.integer "price_cents", limit: 8, default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.string "token"
    t.integer "gateway_id"
    t.string "gateway_customer_id"
    t.string "customer_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gateway_customer_id"], name: "index_purchases_on_gateway_customer_id"
    t.index ["product_id"], name: "index_purchases_on_product_id"
    t.index ["serial_number"], name: "index_purchases_on_serial_number"
    t.index ["token"], name: "index_purchases_on_token"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "links", "purchases"
  add_foreign_key "purchases", "products"
end
