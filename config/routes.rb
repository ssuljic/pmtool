Pmtool::Application.routes.draw do
  root 'base#login_form'

  get 'logout' => 'users#logout'
  get 'sign_up' => 'base#sign_up_form'
  post 'sign_up' => 'base#sign_up'
  post 'login' => 'base#login'

  resources :profiles, :only => [:show, :edit, :update]

  resources :projects do
    collection do
      get 'all'
    end
    resources :members, :only => [:index, :create, :destroy]
    resources :activities
  end
  
  resources :tasks, :only => [:index, :show]
end