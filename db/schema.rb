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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20210629150752) do

  create_table "by_day_of_week_prices", :force => true do |t|
    t.string  "day_desc"
    t.decimal "fixed_price_variation"
    t.decimal "percent_variation"
    t.date    "deleted_at"
  end

  create_table "by_time_of_year_prices", :force => true do |t|
    t.string  "time_desc"
    t.date    "start_date"
    t.date    "end_date"
    t.decimal "fixed_price_variation"
    t.decimal "percent_variation"
    t.date    "deleted_at"
  end

  create_table "customers", :force => true do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone",           :limit => 16
    t.string "email"
    t.string "credit_card_num", :limit => 16
    t.date   "deleted_at"
  end

  create_table "invoice_details", :force => true do |t|
    t.integer "invoice_id"
    t.integer "owner_id"
    t.string  "owner_type"
  end

  create_table "invoices", :force => true do |t|
    t.integer "customer_id"
    t.integer "reservation_id"
    t.date    "issue_date"
    t.date    "payment_reception_date"
    t.decimal "security_deposit"
    t.boolean "is_online_payment"
    t.decimal "total_amount_paid"
    t.decimal "total_amount_due"
    t.decimal "subtotal"
    t.date    "deleted_at"
  end

  create_table "reports", :force => true do |t|
    t.date    "issue_date"
    t.decimal "daily_occupancy_rate"
    t.decimal "total_daily_income"
    t.date    "deleted_at"
  end

  create_table "reservations", :force => true do |t|
    t.integer "customer_id"
    t.date    "start_date"
    t.date    "end_date"
    t.text    "special_request"
    t.boolean "is_online_reservation"
    t.date    "deleted_at"
  end

  create_table "reservations_rooms", :force => true do |t|
    t.integer "reservation_id"
    t.integer "room_id"
  end

  create_table "room_services", :force => true do |t|
    t.integer "report_id"
    t.integer "room_id"
    t.date    "deleted_at"
  end

  create_table "room_types", :force => true do |t|
    t.string  "type_desc"
    t.decimal "type_fixed_price"
    t.decimal "type_percent_variation"
    t.date    "deleted_at"
  end

  create_table "rooms", :force => true do |t|
    t.boolean "is_available"
    t.integer "view_id"
    t.integer "room_type_id"
    t.integer "number"
    t.date    "deleted_at"
  end

  create_table "views", :force => true do |t|
    t.string  "view_desc"
    t.decimal "view_fixed_price"
    t.decimal "view_percent_variation"
    t.date    "deleted_at"
  end

end
