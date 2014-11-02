class UsersController < BaseController
	def logout
		reset_session
		@current_user = nil
		redirect_to root_path
	end
end