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
		@myprojects = @current_user.projects.includes(:user_projects).where('role_id = 1 AND finished=FALSE')
		@assignedprojects = @current_user.projects.includes(:user_projects).where('role_id = 2 AND finished=FALSE' )
		@archievedprojects = @current_user.projects.includes(:user_projects).where('finished=TRUE' )
	end
end