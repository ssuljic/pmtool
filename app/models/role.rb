class Role < ActiveRecord::Base
	has_many :user_projects
	has_many :projects, :through => :user_projects
	def self.manager
		self.where(name: 'Manager').first
	end
	def self.member
		self.where(name: 'Member').first
	end
end