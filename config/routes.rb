Socialrails::Application.routes.draw do
  resources :users do
    get :chatroom, :on => :collection
    member do
      get :following, :followers, :captchas
    end
  end
  resources :sessions,      :only => [:new, :create, :destroy]
  resources :captchas,      :only => [:create, :destroy]
  resources :microposts,    :only => [:create, :destroy] do
    get :fans, :on => :member
  end
  resources :opinions,      :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :hashtags
  resources :messages,      :only => :create

  root :to => 'static_pages#home'

  match '/signup'   => 'users#new'
  match '/signin'   => 'sessions#new'
  match '/signout'  => 'sessions#destroy', :via => :delete
  match '/about'    => 'static_pages#about'
end
