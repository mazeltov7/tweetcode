class RemoveRoomStatusFromRooms < ActiveRecord::Migration
  def change
    remove_column :rooms, :room_status, :string
  end
end
