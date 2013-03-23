Socialrails::Application.routes.draw do
  resources :users do
    collection do
      get :chatroom, :blogs
    end
    member do
      get :following, :followers, :captchas, :blog
    end
  end
  resources :sessions,      :only => [:new, :create, :destroy]
  resources :captchas,      :only => [:create, :destroy]
  resources :microposts,    :only => [:show, :create, :destroy] do
    get :likes, :on => :member
  end
  resources :opinions,      :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :blogs,         :except => :index do
    resources :comments,    :only => [:new, :create, :destroy]
  end
  resources :tags,          :only => :show
  resources :messages,      :only => :create

  root :to => 'pages#home'

  match '/signup'   => 'users#new'
  match '/signin'   => 'sessions#new'
  match '/signout'  => 'sessions#destroy', :via => :delete
  match '/about'    => 'pages#about'
  match '/permalink/:id/' => 'microposts#show', :as => :permalink
end
