class MeetingsController < BaseController
	before_filter :get_user_projects

	def index
		@meetings = Project.find(params[:project_id]).meetings
	end

	def new 
		@meeting = Meeting.new
	end

	def create
		@meeting = Meeting.new(meeting_params)
		@meeting.user = @current_user
		@meeting.project = Project.find(params[:project_id])
		if @meeting.save
			redirect_to new_project_meeting_period_path(:meeting_id => @meeting.id)
		else
			redirect_to root_path
		end
	end

	private
	def meeting_params
		params.require(:meeting).permit(:description, :location)
	end
end
