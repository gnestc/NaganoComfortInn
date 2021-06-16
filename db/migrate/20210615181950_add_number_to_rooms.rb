class AddNumberToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :number, :integer
  end
end
