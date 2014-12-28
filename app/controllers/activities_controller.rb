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

		respond_to do |format|
 			format.html {
 			if @activity.save
		    redirect_to project_activities_path(params[:project_id])
		  else
		    redirect_to new_project_activity_path(params[:project_id])
		  end
 			}
 			format.json {
 				if @activity.save
		      render json: { :message => 'Successful', activity: @activity } 
		    else
		      render json: { :message => 'Unsuccessful'}, :status => :unauthorized
		    end	
 			}
 		end
	end

	def update
		@activity = Activity.find(params[:id])
		if params[:activity][:finished] == "1"
			statuses = @activity.tasks.map { |t| t.status }.uniq
			if statuses.count != 1 && statuses[0] != 100
				flash[:error] = 'All tasks are not finished'
				redirect_to edit_project_activity_path(params[:project_id], params[:id]) and return
			end
		end
		@activity.update(activity_params)
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