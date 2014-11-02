Pmtool::Application.routes.draw do
  root 'base#login_form'

  get 'logout' => 'users#logout'
  post 'login' => 'base#login'

  resources :projects, :only => [:index, :show]
end
