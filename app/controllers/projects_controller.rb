class ProjectsController < BaseController
	before_filter :get_user_projects
	def index
		@tasks = @current_user.tasks.includes(:activity => :project)

		respond_to do |format|
			format.html
			format.json { render json: { :myprojects => @myprojects.includes(:activities => :tasks), 
			:assignedprojects => @assignedprojects.includes(:activities => :tasks), 
			:archievedprojects => @archievedprojects.includes(:activities => :tasks) } }
		end
	end

	def all
		@projects = @current_user.projects.includes(:activities => :tasks)
		respond_to do |format|
			format.html
			format.json {
				render json: { projects: @projects }
			}
		end
	end

	def show
		@project = @current_user.projects.includes(:activities => :tasks).find(params[:id])

		respond_to do |format|
			format.html
			format.json { 
				render json: { project: @project }
			}
		end
	end

	def new
		@project = Project.new
	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])
		if @project.update(project_params)
			redirect_to project_path(params[:id])		
		else 
			flash[:error] = ""
			@project.errors.messages.each {|k, v| flash[:error] << "#{k.to_s.capitalize} #{v[0]}; " }
			redirect_to edit_project_path(@project)
		end
	end

	def create
		@project = Project.new(project_params)
 		respond_to do |format|
 			format.html {
 				if @project.save
 					@project.manager = @current_user
		    	redirect_to projects_path
		  	else
		      render new_project_path
		    end
 			}
 			format.json {
 				if @project.save
 					@project.manager = @current_user
		      		render json: { :message => 'Successful', project: @project } 
		    	else
		      		render json: { :message => 'Unsuccessful'}, :status => :unauthorized
		    end	
 			}
 		end
	end

	def status
	end

	private

	def project_params
		params[:project][:finished] = false
		params.require(:project).permit(:name, 
			:short_description, 
			:long_description, 
			:start_date, 
			:end_date,
			:duration,
			:member_count,
			:budget,
			:finished)
	end
end