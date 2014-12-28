require 'base64'
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
		respond_to do |format|
			format.html {
				@upload = Upload.new
				@upload.file_data = params[:upload][:file_data]
				@upload.task = Task.find(params[:task_id])
				@upload.save_binary
				@upload.save
				redirect_to :back
			}
			format.json {
				render json: {message: 'OK'}	
			}
		end
	end

	def show
		@upload = Upload.find(params[:id])
		@data = @upload.binary.data

		send_data(@data, :type => @upload.content_type, :filename => @upload.filename, :disposition => 'download')
	end
end