class User < ActiveRecord::Base
	has_many :user_projects
	has_many :projects, :through => :user_projects
	has_many :tasks
	has_many :uploads, :through => :tasks
	#Callbacks because some database adapters use case-sensitive indices
	before_save { self.email = email.downcase } 
	before_save { self.username = username.downcase }
	validates :name, presence: true, length: {minimum: 3, maximum: 25}
	validates :surname, presence: true, length: {minimum: 3, maximum: 35}
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: {minimum: 5, maximum: 255}, format: { with: VALID_EMAIL_REGEX },
	                    uniqueness: { case_sensitive: false }
	validates :username, presence: true, length: {minimum: 5, maximum: 15},
	                    uniqueness: { case_sensitive: false }
	has_secure_password
	# validates :password, length: { minimum: 6 }

	def projects_by_role(role)
		self.projects.includes(:user_projects).where('role_id = ? AND finished=FALSE', role.id)
	end

	def archieved_projects
		self.projects.includes(:user_projects).where('finished=TRUE')
	end

	def is_manager?(project)
		self.projects.find(project).roles.includes(:user_projects).where('user_id = ?', self.id).first == Role.manager
	end

	def get_available_hours(project_id)
		self.user_projects.where('project_id = ?' , project_id).first.number_of_hours - get_busy_hours(project_id)
	end

	def get_busy_hours(project_id)
		self.projects.find(project_id).tasks.where('user_id = ?', self.id).sum(:duration)
	end

	def get_tasks_count(project_id)
		self.projects.find(project_id).tasks.where('user_id = ?', self.id).count
	end
	#def get_available_hours(project)
	#end
end