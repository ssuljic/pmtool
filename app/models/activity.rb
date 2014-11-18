class Activity < ActiveRecord::Base
	belongs_to :project
	has_many :tasks

	def serializable_hash(options={})
	  super(:include =>[:tasks])
	end
end