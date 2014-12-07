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
		@user.session_key = Digest::SHA256.hexdigest(params[:user][:password])
		respond_to do |format|
			format.html {
				if @user.save
			  redirect_to root_path
			else
			  redirect_to sign_up_path
			end
			}
			format.json {
				if @user.save
			  render json: { :signup => 'Successful'} 
			else
			  render json: { :signup => 'Unsuccessful'}, :status => :unauthorized
			end	
			}
	  end

	end

	def login
		user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
		respond_to do |format|
			format.html {
				if user
					session[:id] = user.id
					redirect_to projects_path and return
				end
				flash[:alert] = "Username or password are incorrect!"
				redirect_to root_path
			}
			format.json {
				if user
					render json: { :key => user.session_key }
				else
					render json: { :error => 'Bad authentication'}, :status => :unauthorized
				end
			}
		end
	end
	
	private
	def authorization_check
		if params[:key]
			@current_user = User.where(:username => params[:username], :session_key => params[:key]).first
			render json: { :error => 'Bad authentication' } and return unless @current_user
		elsif !session[:id].nil?
			@current_user = User.find(session[:id])
		else
			redirect_to root_path
		end
	end

	def get_user_projects
		@myprojects = @current_user.projects_by_role(Role.manager)
		@assignedprojects = @current_user.projects_by_role(Role.member)
		@archievedprojects = @current_user.archieved_projects
	end

	def user_params
		params.require(:user).permit(:name, :surname, :email, :username, :password,:password_confirmation)
	end
end