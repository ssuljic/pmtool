class TasksController < BaseController
	before_filter :get_user_projects
	def index
		# begin
			if params[:activity_id] && params[:project_id]
				activity = @current_user.projects.find(params[:project_id]).activities.find(params[:activity_id])
				@tasks = activity.tasks.includes(:uploads)
			elsif params[:project_id]
				project = @current_user.projects.find(params[:project_id])
				@tasks = project.tasks.includes(:uploads)
			else
				@tasks = @current_user.tasks.includes(:uploads)
			end
			
			respond_to do |format|
				format.html
				format.json {
					render json: { tasks: @tasks }
				}
			end
		# rescue
		# 	render json: { message: 'Record not found!' }, :status => :bad_request
		# end
	end

	def show
		begin
			if params[:activity_id] && params[:project_id]
				activity = @current_user.projects.find(params[:project_id]).activities.find(params[:activity_id])
				render json: activity.tasks.find(params[:id])
			elsif params[:project_id]
				project = @current_user.projects.find(params[:project_id])
				render json: { task: project.tasks.find(params[:id]) }
			else
				render json: { task: @current_user.tasks.find(params[:id]) }
			end
		rescue
			render json: { message: 'Record not found!' }, :status => :bad_request
		end
	end

	def new
		@task = Task.new
		@users = Activity.find(params[:activity_id]).project.users
	end

	def create
		@task = Task.new(task_params)
		respond_to do |format|
 			format.html {
 			if @task.save
		    redirect_to tasks_path(project_id: Activity.find(task_params[:activity_id]).project.id, activity_id: task_params[:activity_id])
		  else
		    redirect_to new_task_path
		  end
 			}
 			format.json {
 				if @task.save
		      render json: { :message => 'Successful', task: @task } 
		    else
		      render json: { :message => 'Unsuccessful'}, :status => :unauthorized
		    end	
 			}
 		end
	end

	def edit
		@task = Task.find(params[:id])
		@users = Activity.find(params[:activity_id]).project.users
	end

	def update
		Task.find(params[:id]).update(task_params)
		redirect_to tasks_path(project_id: Activity.find(task_params[:activity_id]).project.id, activity_id: task_params[:activity_id])
	end

	private
	def task_params
		params.require(:task).permit(:name,
			:description,
			:duration,
			:deadline,
			:status,
			:user_id,
			:activity_id
			)
	end

end