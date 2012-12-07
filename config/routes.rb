Socialrails::Application.routes.draw do
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions,      :only => [:new, :create, :destroy]
  resources :captchas,      :only => [:index, :create, :destroy]
  resources :microposts,    :only => [:create, :show, :destroy]
  resources :opinions,      :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]

  root :to => 'static_pages#home'

  match '/signup'   => 'users#new'
  match '/signin'   => 'sessions#new'
  match '/signout'  => 'sessions#destroy', :via => :delete
  match '/about'    => 'static_pages#about'
end
