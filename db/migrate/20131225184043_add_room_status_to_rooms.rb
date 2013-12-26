class AddRoomStatusToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :room_status, :string
  end
end
