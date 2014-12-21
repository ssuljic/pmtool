class AddPeriodTable < ActiveRecord::Migration
  def change
  	create_table :period do |t|
  		t.references :meeting, :null => false
  		t.date :from
  		t.date :to

  		t.timestamps
  	end
  end
end
