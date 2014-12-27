class AddPeriodTable < ActiveRecord::Migration
  def change
  	create_table :periods do |t|
  		t.references :meeting, :null => false
  		t.datetime :from
  		t.datetime :to

  		t.timestamps
  	end
  end
end
