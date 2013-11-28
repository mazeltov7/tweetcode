class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :string
    add_column :users, :profile, :text
  end
end
