class AddTableUserPeriod < ActiveRecord::Migration
  def change
  	create_table :user_periods do |t|
  		t.references :period, :null => false
  		t.references :user, :null => false 

  		t.timestamps
  	end
  end
end
