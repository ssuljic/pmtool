class MeetingsController < BaseController
	before_filter :get_user_projects

	def show
		@meeting = Meeting.find(params[:id])
	end

	def index
		@meetings = Project.find(params[:project_id]).meetings
	end

	def new 
		@meeting = Meeting.new
	end

	def finish
		@meeting = Meeting.find(params[:meeting_id])
		@meeting.scheduling_finished = TRUE
		@meeting.save
		@p=Period.find(params[:period])
		@p.picked = TRUE
		@p.save
		redirect_to project_meetings_path
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
