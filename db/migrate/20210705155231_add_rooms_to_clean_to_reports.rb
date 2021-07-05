class AddRoomsToCleanToReports < ActiveRecord::Migration
  def change
    add_column :reports, :rooms_to_clean_qty, :integer
  end
end
