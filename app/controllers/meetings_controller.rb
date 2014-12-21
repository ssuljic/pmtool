class MeetingsController < BaseController
	before_filter :get_user_projects

	def new 
		@meeting = Meeting.new
	end

	def create
	end
end
