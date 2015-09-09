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

ActiveRecord::Schema.define(version: 20150908083147) do

  create_table "ad_views", force: :cascade do |t|
    t.integer  "brokerage_id", limit: 4
    t.integer  "user_id",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "advisors", force: :cascade do |t|
    t.string   "first_name",  limit: 255
    t.string   "last_name",   limit: 255
    t.string   "image",       limit: 255
    t.string   "phone",       limit: 10
    t.string   "email",       limit: 255
    t.string   "address1",    limit: 255
    t.string   "address2",    limit: 255
    t.string   "city",        limit: 255
    t.string   "state",       limit: 255
    t.string   "zip",         limit: 5
    t.boolean  "is_verified", limit: 1
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "has_advisor", limit: 1
  end

  create_table "brokerages", force: :cascade do |t|
    t.string   "phone",       limit: 255
    t.string   "email",       limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "address1",    limit: 255
    t.string   "address2",    limit: 255
    t.string   "city",        limit: 255
    t.string   "state",       limit: 255
    t.string   "zip",         limit: 255
    t.string   "image",       limit: 255
    t.boolean  "is_verified", limit: 1
    t.text     "about",       limit: 65535
    t.string   "name",        limit: 255
  end

  create_table "brokers", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "brokerage_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "broker_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "rating",     limit: 4
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "investments", force: :cascade do |t|
    t.string   "ticker",       limit: 255
    t.integer  "quantity",     limit: 4
    t.integer  "portfolio_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "mutual_fund_warehouses", force: :cascade do |t|
    t.string   "ticker",        limit: 255
    t.string   "name",          limit: 255
    t.string   "objective",     limit: 255
    t.float    "twelve_b_1",    limit: 24
    t.float    "back_load",     limit: 24
    t.float    "front_load",    limit: 24
    t.float    "expense_ratio", limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "mutual_funds", force: :cascade do |t|
    t.string   "ticker",        limit: 255
    t.float    "nav",           limit: 24
    t.float    "expense_ratio", limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "auto_updated"
    t.float    "load",          limit: 24
    t.float    "twelve_b_1",    limit: 24
  end

  create_table "organization_admins", force: :cascade do |t|
    t.integer  "organization_id", limit: 4
    t.integer  "user_id",         limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "organization_advisors", force: :cascade do |t|
    t.integer  "organization_id", limit: 4
    t.integer  "advisor_id",      limit: 4
    t.boolean  "is_verified",     limit: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "image",       limit: 255
    t.string   "phone",       limit: 10
    t.string   "email",       limit: 255
    t.string   "address1",    limit: 255
    t.string   "address2",    limit: 255
    t.string   "city",        limit: 255
    t.string   "state",       limit: 255
    t.string   "zip",         limit: 5
    t.boolean  "is_verified", limit: 1
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.float    "management_fee", limit: 24
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "nickname",       limit: 255
  end

  create_table "suggestions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.text     "message",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "user_advisors", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "advisor_id",  limit: 4
    t.boolean  "is_verified", limit: 1
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "remember_digest", limit: 255
  end

end
