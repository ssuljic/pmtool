class TasksController < BaseController
	def index
		begin
			if params[:activity_id] && params[:project_id]
				activity = @current_user.projects.find(params[:project_id]).activities.find(params[:activity_id])
				render json: activity.tasks
			elsif params[:project_id]
				project = @current_user.projects.find(params[:project_id])
				render json: project.tasks
			else
				render json: @current_user.tasks
			end
		rescue
			render json: { message: 'Record not found!' }, :status => :bad_request
		end
	end

	def show
		begin
			if params[:activity_id] && params[:project_id]
				activity = @current_user.projects.find(params[:project_id]).activities.find(params[:activity_id])
				render json: activity.tasks.find(params[:id])
			elsif params[:project_id]
				project = @current_user.projects.find(params[:project_id])
				render json: project.tasks.find(params[:id])
			else
				render json: @current_user.tasks.find(params[:id])
			end
		rescue
			render json: { message: 'Record not found!' }, :status => :bad_request
		end
	end
end