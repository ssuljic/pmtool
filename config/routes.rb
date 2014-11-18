Pmtool::Application.routes.draw do
  root 'base#login_form'

  get 'logout' => 'users#logout'
  get 'sign_up' => 'base#sign_up_form'
  post 'sign_up' => 'base#sign_up'
  post 'login' => 'base#login'

  resources :projects, :only => [:index, :show, :new, :create] do
  	collection do
  		get 'all'
  	end
  end
  resources :activities, :only => [:index, :show]
  resources :tasks, :only => [:index, :show]
end
