class ActivitiesController < BaseController
	before_filter :get_user_projects
	def index
		@project = @current_user.projects.find(params[:project_id])
		respond_to do |format|
			format.html
			format.json {
				begin
					render json: { activities: @project.activities }
				rescue
					render json: { message: 'Record not found!' }, :status => :bad_request
				end
			}
		end
	end

	def show
		begin
			project = @current_user.projects.find(params[:project_id])
			render json: { activity: project.activities.find(params[:id]) }
		rescue
			render json: { message: 'Record not found!' }, :status => :bad_request
		end
	end

	def edit
		@activity = Activity.find(params[:id])
	end

	def new
		@activity = Activity.new
	end

	def create
		@activity = Activity.new(activity_params)
		@activity.project = Project.find(params[:project_id])
		@activity.save!

		redirect_to project_activities_path(params[:project_id])
	end

	def update
		Activity.find(params[:id]).update(activity_params)
		redirect_to project_activities_path(params[:project_id])
	end

	def destroy
		Activity.destroy(params[:id])
		redirect_to project_activities_path(Project.find(params[:project_id]))
	end

	private
	def activity_params
		params.require(:activity).permit(:name, :description, :duration, :finished)
	end
end