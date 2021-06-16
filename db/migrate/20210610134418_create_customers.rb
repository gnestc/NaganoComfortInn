class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone, limit: 16
      t.string :email
      t.string :credit_card_num, limit: 16
    end

    create_table :reservations do |t|
      t.integer :customer_id
      t.date :start_date
      t.date :end_date
      t.text :special_request
      t.boolean :is_online_reservation
    end

    create_table :room_types do |t|
      t.string :type_desc
      t.decimal :type_fixed_price
      t.decimal :type_percent_variation
    end

    create_table :views do |t|
      t.string :view_desc
      t.decimal :view_fixed_price
      t.decimal :view_percent_variation
    end

    create_table :rooms do |t|
      t.boolean :is_available
      t.belongs_to :view
      t.belongs_to :room_type
    end

    create_table :reservations_rooms do |t|
      t.belongs_to :reservation
      t.belongs_to :room
    end

    create_table :reports do |t|
      t.date :issue_date
      t.decimal :daily_occupancy_rate
      t.decimal :total_daily_income
    end

    create_table :room_services do |t|
      t.belongs_to :report
      t.belongs_to :room
    end

    create_table :invoices do |t|
      t.belongs_to :customer
      t.belongs_to :reservation
      t.date :issue_date
      t.date :payment_reception_date
      t.decimal :security_deposit
      t.boolean :is_online_payment
      t.decimal :total_amount_paid
      t.decimal :total_amount_due
      t.decimal :subtotal
    end

    create_table :by_day_of_week_prices do |t|
      t.string :day_desc
      t.decimal :fixed_price_variation
      t.decimal :percent_variation
    end

    create_table :by_time_of_year_prices do |t|
      t.string :time_desc
      t.date :start_date
      t.date :end_date
      t.decimal :fixed_price_variation
      t.decimal :percent_variation
    end

    create_table :invoice_details do |t|
      t.belongs_to :invoice
      t.references :owner, polymorphic:true
    end
  end
end
