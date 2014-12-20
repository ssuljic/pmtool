class Task < ActiveRecord::Base
	belongs_to :activity
	belongs_to :user
	has_many :comments
	has_many :uploads

	def serializable_hash(options={})
	  super(:include => :uploads)
	end


end