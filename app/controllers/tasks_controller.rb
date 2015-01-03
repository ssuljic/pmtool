class TasksController < BaseController
	before_filter :get_user_projects
	def index
		begin
			
			if params[:activity_id] && params[:project_id]
				@activity = @current_user.projects.find(params[:project_id]).activities.find(params[:activity_id])
				@tasks = @activity.tasks.includes(:uploads)
			elsif params[:user_id] && params[:project_id]
				@my_tasks = TRUE
				@tasks = Project.find(params[:project_id]).tasks.includes(:uploads).where('user_id = ?', params[:user_id])
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
		@activity = Activity.find(params[:activity_id])
		@users = @activity.project.users
	end

	def create
		@project = Activity.find(task_params[:activity_id]).project
		@task = Task.new(task_params)
		respond_to do |format|
 			format.html {

 			user_id = params[:task][:user_id] || @current_user.id

			if params[:task][:duration].to_i > User.find(user_id).get_available_hours(@project)
				flash[:error] = "Selected user doesn't have enough available hours"
				redirect_to new_task_path(activity_id: task_params[:activity_id]) and return
			end
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
		@activity = Activity.find(params[:activity_id])
		@users = @activity.project.users

		redirect_to projects_path if @task.user != @current_user && !@current_user.is_manager?(@activity.project)
	end

	def update
		@project = Activity.find(task_params[:activity_id]).project
		@task = Task.find(params[:id])

		user_id = params[:task][:user_id] || @current_user.id

		if params[:task][:duration].to_i > User.find(user_id).get_available_hours(@project)
			flash[:error] = "Selected user doesn't have enough available hours"
			redirect_to edit_task_path(activity_id: task_params[:activity_id], id: params[:id]) and return
		end

		@task.update(task_params)
		redirect_to tasks_path(project_id: @project.id, activity_id: task_params[:activity_id])
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