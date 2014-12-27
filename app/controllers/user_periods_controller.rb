class UserPeriodsController < BaseController
	before_filter :get_user_projects
	def new
		@user_period = UserPeriod.new
		@meeting = Meeting.find(params[:meeting_id])
	end

	def create
		params[:user_period].each do |param|
			@user_period = UserPeriod.new
			@user_period.user = User.find(@current_user.id)
			@user_period.period = Period.find(param)
			@user_period.save
		end
		redirect_to project_meetings_path
	end
end