class CommentsController < BaseController
	before_filter :get_user_projects
	def create
		@comm = Comment.new(comment_params)
		if @comm.save
			redirect_to tasks_path(project_id: Activity.find(params[:activity_id]).project.id, activity_id: params[:activity_id])
		else
			redirect_to tasks_path(project_id: Activity.find(params[:activity_id]).project.id, activity_id: params[:activity_id])
		end
	end

	private
	def comment_params
		params.permit(:user_id,
			:task_id,
			:content
		)
	end

end
