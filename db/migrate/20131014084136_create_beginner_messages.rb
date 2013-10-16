class CreateBeginnerMessages < ActiveRecord::Migration
  def change
    create_table :beginner_messages do |t|
      t.text :body
      t.integer :user_id

      t.timestamps
    end
  end
end
