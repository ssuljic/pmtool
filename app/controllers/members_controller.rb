class MembersController < BaseController
	before_filter :get_user_projects
	def index
		@avail_usernames = Project.find(params[:project_id]).get_available_users.map{|u| u.username}
		@members = @current_user.projects.find(params[:project_id]).users.includes(:user_projects)		
	end

	def create
		params[:tags].split(',').each do |new_member|
			@current_user.projects.find(params[:project_id]).member = User.find_by_username(new_member)
		end
		redirect_to project_members_path
	end

	def destroy
		if (User.find(params[:id]).get_tasks_count(params[:project_id])==0) 
			UserProject.where(:user_id=>params[:id]).where(:project_id=>params[:project_id]).first.destroy
		end
		redirect_to project_members_path
	end
end
