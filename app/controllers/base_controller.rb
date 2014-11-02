# encoding: UTF-8
class BaseController < ApplicationController
	def login_form
		if session[:id]
			redirect_to projects_path
		end
	end

	def login
		user = User.where(:username => params[:username]).first
		if (user)
			if (user.password == Digest::SHA256.hexdigest(params[:password]))
				session[:id] = user.id
				session[:shift] = params[:shift]
				redirect_to projects_path
				return
			end
		end

		flash[:alert] = "Username or password are incorrect!"
		redirect_to root_path
	end
	
	private
	def authorization_check
		unless session[:id]
			redirect_to root_path
		else
			@current_user = User.find(session[:id])
			@shift = session[:shift]
		end
	end
end