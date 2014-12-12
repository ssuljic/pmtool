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
	end
end
