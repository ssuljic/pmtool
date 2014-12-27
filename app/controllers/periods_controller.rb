class PeriodsController < BaseController
	before_filter :get_user_projects

	def new 
		@period = Period.new
	end

	def create
		@period = Period.new(period_params)
		@period.meeting = Meeting.find(params[:meeting_id])
		if @period.save
			redirect_to new_project_meeting_period_path(:meeting_id => params[:meeting_id])
		else
			redirect_to root_path			
		end
	end

	private
	def period_params
		params.require(:period).permit(:from, :to)
	end
end