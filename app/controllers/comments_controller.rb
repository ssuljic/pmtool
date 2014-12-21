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
		content = 'content'+params[:comment][:task_id]
		params[:comment][:content]=params[:comment][content]
		params[:activity_id]=params[:comment][:activity_id]
		params.require(:comment).permit(:content,
			:user_id,
			:task_id,
		)
	end

end
