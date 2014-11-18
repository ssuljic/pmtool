class ActivitiesController < BaseController
	def index
		begin
			project = @current_user.projects.find(params[:project_id])
			render json: project.activities
		rescue
			render json: { message: 'Record not found!' }, :status => :bad_request
		end
	end

	def show
		begin
			project = @current_user.projects.find(params[:project_id])
			render json: project.activities.find(params[:id])
		rescue
			render json: { message: 'Record not found!' }, :status => :bad_request
		end
	end
end