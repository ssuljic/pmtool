class Meeting < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
	has_many :periods

end
