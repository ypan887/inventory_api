# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160311070402) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "country"
    t.string   "zip_code"
    t.boolean  "photo_id",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "merchants", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity",   default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "order_details", ["order_id"], name: "index_order_details_on_order_id"
  add_index "order_details", ["product_id"], name: "index_order_details_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.date     "order_date"
    t.integer  "customer_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.float    "cost"
    t.string   "description"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"

  create_table "shipment_details", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "shipment_id"
    t.integer  "product_id"
    t.boolean  "deliver_check", default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "shipment_details", ["product_id"], name: "index_shipment_details_on_product_id"
  add_index "shipment_details", ["shipment_id"], name: "index_shipment_details_on_shipment_id"

  create_table "shipments", force: :cascade do |t|
    t.string   "tracking_number"
    t.date     "ship_date"
    t.float    "ship_cost"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "statements", force: :cascade do |t|
    t.float    "profit",        default: 0.0
    t.float    "income",        default: 0.0
    t.float    "shipping_cost", default: 0.0
    t.float    "product_cost",  default: 0.0
    t.string   "year_month"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "supplies", force: :cascade do |t|
    t.date     "order_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "merchant_id"
  end

  add_index "supplies", ["merchant_id"], name: "index_supplies_on_merchant_id"

  create_table "supply_details", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "supply_id"
    t.integer  "product_id"
    t.boolean  "deliver_check", default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "supply_details", ["product_id"], name: "index_supply_details_on_product_id"
  add_index "supply_details", ["supply_id"], name: "index_supply_details_on_supply_id"

end
