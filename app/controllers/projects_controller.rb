class ProjectsController < BaseController
	before_filter :get_user_projects

	def index
		@tasks = @current_user.tasks.includes(:activity => :project)

		respond_to do |format|
			format.html
			format.json { render json: @projects.to_json(:include => {:activities => {:include => :tasks}}) }
		end
	end

	def show
		@project = @current_user.projects.includes(:activities => :tasks).find(params[:id])

		respond_to do |format|
			format.html
			format.json { render json: @project.to_json(:include => {:activities => {:include => :tasks}}) }
		end
	end

	private
	def get_user_projects
		@projects = @current_user.projects.includes(:activities => :tasks)
	end
end