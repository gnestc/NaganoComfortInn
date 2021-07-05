class AddCreatedAtToRoomServices < ActiveRecord::Migration
  def change
    add_column :room_services, :created_at, :date
    remove_column :room_services, :report_id
  end
end
