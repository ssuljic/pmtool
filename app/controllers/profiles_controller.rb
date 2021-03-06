class ProfilesController < BaseController
	before_filter :get_user_projects

	def show
		@user = @current_user
	end

	def edit		
	end

	def update
		if params[:user][:old_password].empty?
			@current_user.name = params[:user][:name]
			@current_user.surname = params[:user][:surname]
			@current_user.email = params[:user][:email]
			@current_user.username = params[:user][:username]
			if @current_user.save
				flash[:success] = "Succesfully updated profile"
				redirect_to profile_path(@current_user) and return
			else
				@current_user.errors.messages.each {|k, v| flash[:error] = "#{k.to_s.capitalize} #{v[0]}" }
				redirect_to edit_profile_path(@current_user) and return
			end
		end
		if @current_user.try(:authenticate, params[:user][:old_password])
			if @current_user.update(user_params)
				flash[:success] = "Succesfully updated profile"
				redirect_to profile_path(@current_user) and return
			else
				@current_user.errors.messages.each {|k, v| flash[:error] = "#{k.to_s.capitalize} #{v[0]}" }
				redirect_to edit_profile_path(@current_user) and return
			end
		else
			flash[:error] = "Invalid old password"
			redirect_to edit_profile_path(@current_user) and return
		end
	end

end