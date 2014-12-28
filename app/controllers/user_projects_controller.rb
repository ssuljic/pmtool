class UserProjectsController < BaseController
	before_filter :get_user_projects

	def edit
		@user_project = UserProject.find(params[:id])
		redirect_to projects_path unless @user_project.user == @current_user
	end

	def update
		@user_project = UserProject.find(params[:id])
		@project = Project.find(params[:project_id])

		if params[:user_project][:number_of_hours].to_i < @current_user.get_busy_hours(@project)
			flash[:error] = "Cannot update commitment because there are already tasks assigned on you which duration is greater"
			redirect_to edit_project_user_project_path(project_id: @project, id: @user_project) and return
		end
		@user_project.update(number_of_hours: params[:user_project][:number_of_hours])
		redirect_to project_path(params[:project_id])
	end
end