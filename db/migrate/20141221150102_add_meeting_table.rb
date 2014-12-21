class AddMeetingTable < ActiveRecord::Migration
  def change
  	create_table :meeting do |t|
  		t.references :project, :null => false
  		# meeting creator
  		t.references :user, :null => false
  		t.string :description
  		t.string :location
  		t.boolean :scheduling_finished
  		t.integer :attending_members

  		t.timestamps
  	end
  end
end
