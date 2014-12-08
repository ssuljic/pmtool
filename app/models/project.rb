class Project < ActiveRecord::Base
	has_many :activities
	has_many :user_projects
	has_many :users, :through => :user_projects
	has_many :roles, :through => :user_projects
	has_many :tasks, -> { distinct }, :through => :activities

	def manager=(user)
		UserProject.create(project: self, user: user, role: Role.manager)
	end

	def serializable_hash(options={})
	  super(:include =>[:activities => { :include => :tasks }])
	end
end