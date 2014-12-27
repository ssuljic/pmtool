class MeetingsController < BaseController
	before_filter :get_user_projects

	def new 
		@meeting = Meeting.new
		@period = Period.new
	end

	def create
	end
end
