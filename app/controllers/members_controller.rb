class MembersController < BaseController
	before_filter :get_user_projects
	def index
		if(params[:error]) 
			@error=params[:error]
		end
		@project = Project.find(params[:project_id])
		@avail_usernames = @project.get_available_users.map{|u| u.username}
		@members = @current_user.projects.find(params[:project_id]).users.includes(:user_projects)
		@members_limit = @project.member_count - @members.length
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
			redirect_to project_members_path
		else
			redirect_to project_members_path(:error => "This member can't be removed, since he has assigned tasks.")
		end
	end

end
