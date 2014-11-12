class User < ActiveRecord::Base
	has_many :user_projects
	has_many :projects, :through => :user_projects
	has_many :tasks
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
	validates :password, length: { minimum: 6 }
end