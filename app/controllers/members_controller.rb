class MembersController < BaseController
	before_filter :get_user_projects
	def index
		@avail_usernames =[]
		Project.find(params[:project_id]).get_available_users.each do |u|
			@avail_usernames << u.username
		end
		@avail_usernames.to_json
		@members = @current_user.projects.find(params[:project_id]).users.includes(:user_projects)
	end

	def destroy
		
	end
end
