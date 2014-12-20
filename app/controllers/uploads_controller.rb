class UploadsController < BaseController
	before_filter :get_user_projects

	def index
		@uploads = Task.find(params[:task_id]).uploads
		render json: @uploads
	end
	
	def new
		@upload = Upload.new
	end

	def create
		@upload = Upload.new
		@upload.file_data = params[:upload][:file_data]
		@upload.task = Task.find(params[:task_id])
		@upload.save
		redirect_to tasks_path
	end

	def show
		@upload = Upload.find(params[:id])
		@data = @upload.binary.data

		send_data(@data, :type => @upload.content_type, :filename => @upload.filename, :disposition => 'download')
	end
end