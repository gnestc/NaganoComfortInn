class AddDeletedAt < ActiveRecord::Migration
  def change
    add_column :rooms, :deleted_at, :date
    add_column :reservations, :deleted_at, :date
    add_column :customers, :deleted_at, :date
    add_column :room_types, :deleted_at, :date
    add_column :views, :deleted_at, :date
    add_column :invoices, :deleted_at, :date
    add_column :by_day_of_week_prices, :deleted_at, :date
    add_column :by_time_of_year_prices, :deleted_at, :date
    add_column :room_services, :deleted_at, :date
    add_column :reports, :deleted_at, :date
  end
end
