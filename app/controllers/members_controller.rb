class MembersController < BaseController
	before_filter :get_user_projects
	def index
		@members = @current_user.projects.find(params[:id]).users.includes(:user_projects)
	end
end
