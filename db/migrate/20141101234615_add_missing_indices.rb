class AddMissingIndices < ActiveRecord::Migration
  def up
  	# Add indices to FKs
  	add_index :activities, :project_id
  	add_index :tasks, :activity_id
  	add_index :tasks, :user_id
  	add_index :user_projects, :user_id
  	add_index :user_projects, :project_id
  	add_index :user_projects, :role_id
  	add_index :user_activities, :user_id
  	add_index :user_activities, :activity_id
  	add_index :user_activities, :role_id
  end
end
