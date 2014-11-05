# encoding: UTF-8
class BaseController < ApplicationController
	def login_form
		if session[:id]
			redirect_to projects_path
		end
	end

	def sign_up_form
  		@user = User.new
	end

	def sign_up
 		@user = User.new(user_params)
	    if @user.save
	      redirect_to root_path
	    else
	      raise
	      redirect_to sign_up_path
	    end
	end

	def login
		user = User.where(:username => params[:username]).first
		if (user)
			if (user.password_digest == Digest::SHA256.hexdigest(params[:password]))
				session[:id] = user.id
				redirect_to projects_path
				return
			end
		end
		raise
		flash[:alert] = "Username or password are incorrect!"
		redirect_to root_path
	end
	
	private
	def authorization_check
		unless session[:id]
			redirect_to root_path
		else
			@current_user = User.find(session[:id])
		end
	end

    def user_params
      params.require(:user).permit(:name, :surname, :email, :username, :password,
                                   :password_confirmation)
    end
end