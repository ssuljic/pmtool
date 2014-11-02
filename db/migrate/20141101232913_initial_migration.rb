class InitialMigration < ActiveRecord::Migration
  def up
  	create_table :users do |t|
  		t.string :name
  		t.string :surname
  		t.string :email
  		t.string :username
  		t.string :password

  		t.timestamps
  	end

  	create_table :projects do |t|
  		t.string :name
  		t.text :short_description
  		t.text :long_description
  		t.date :start_date
  		t.date :end_date
  		t.integer :duration
  		t.integer :member_count
  		t.float :budget
  		t.boolean :finished

  		t.timestamps
  	end

  	create_table :activities do |t|
  		t.references :project, :null => false
  		t.string :name
  		t.text :description
  		t.integer :duration
  		t.boolean :finished

  		t.timestamps
  	end

  	create_table :tasks do |t|
  		t.references :activity, :null => false
  		t.references :user, :null => false
  		t.string :name
  		t.text :description
  		t.integer :duration
  		t.date :deadline
  		t.float :status
  		t.integer :real_duration

  		t.timestamps
  	end

  	create_table :roles do |t|
  		t.string :name

  		t.timestamps
  	end

  	create_table :user_projects do |t|
  		t.references :user, :null => false
  		t.references :project, :null => false
  		t.references :role, :null => false
  		t.integer :number_of_hours

  		t.timestamps
  	end

  	create_table :user_activities do |t|
  		t.references :user, :null => false
  		t.references :activity, :null => false
  		t.references :role, :null => false

  		t.timestamps
  	end
  end

  def down
  	drop_table :users
  	drop_table :projects
  	drop_table :activities
  	drop_table :tasks
  	drop_table :roles
  	drop_table :user_projects
  	drop_table :user_activities
  end
end

