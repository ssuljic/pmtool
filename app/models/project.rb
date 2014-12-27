class Project < ActiveRecord::Base
	has_many :activities
	has_many :user_projects
	has_many :meetings
	has_many :users, :through => :user_projects
	has_many :roles, :through => :user_projects
	has_many :tasks, -> { distinct }, :through => :activities

	def manager=(user)
		UserProject.create(project: self, user: user, role: Role.manager, number_of_hours: 0)
	end

	def member=(user)
		UserProject.create(project: self, user: user, role: Role.member, number_of_hours: 0)
	end

	def serializable_hash(options={})
	  super(:include =>[:activities => { :include => :tasks }])
	end

	def get_available_users
		a = []
		self.users.each do |u|
			a << u.id
		end
		User.where('id not in (?)', a)
	end
end