class Role < ActiveRecord::Base
	def self.manager
		self.where(name: 'Manager').first
	end
	def self.member
		self.where(name: 'Member').first
	end
end