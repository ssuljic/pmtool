class Project < ActiveRecord::Base
	has_many :activities
	has_many :user_projects
	has_many :users, :through => :user_projects
	has_many :tasks, -> { distinct }, :through => :activities
end