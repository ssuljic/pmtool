class AddSessionKeyToUser < ActiveRecord::Migration
  def up
  	add_column :users, :session_key, :string
  end

  def down
  	remove_column :users, :session_key
  end
end
