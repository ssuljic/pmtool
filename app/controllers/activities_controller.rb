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

	def destroy
		Activity.destroy(params[:id])
		redirect_to project_activities_path(Project.find(params[:project_id]))
	end
end