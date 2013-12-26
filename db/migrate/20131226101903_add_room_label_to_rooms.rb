class AddRoomLabelToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :room_label, :string
  end
end
