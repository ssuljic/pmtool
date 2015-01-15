class Project < ActiveRecord::Base
	has_many :activities
	has_many :user_projects
	has_many :meetings
	has_many :users, :through => :user_projects
	has_many :roles, :through => :user_projects
	has_many :tasks, -> { distinct }, :through => :activities
	validates :name, presence: true
	validates :short_description, presence: true
	validates :start_date, presence: true
	validates :end_date, presence: true
	validates :duration, presence: true

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

	def finished_activities_count
		self.activities.to_a.map { |a| a.finished ? 1 : 0 }.reduce(0, :+)
	end

	def finished_tasks_count
		self.tasks.to_a.map { |a| a.status == 100 ? 1 : 0 }.reduce(0, :+)
	end
end