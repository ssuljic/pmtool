class AddTableComments < ActiveRecord::Migration
  def change
  	create_table :comments do |t|
  		t.references :user, :null => false
  		t.references :task, :null => false
  		t.string :content

  		t.timestamps
  	end
  end
end
