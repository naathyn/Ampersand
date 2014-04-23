Socialrails::Application.routes.draw do
  resources :users do
    collection do
      get :chatroom, :blogs
    end
    member do
      get :following, :followers, :captchas, :blog
    end
    resources :private_messages, except: :edit do
      post :delete_selected, on: :collection
    end   
  end
  resources :sessions,      only: [:new, :create, :destroy]
  resources :captchas,      only: [:create, :destroy]
  resources :microposts,    only: [:show, :create, :destroy] do
    get :likes, on: :member
  end
  resources :opinions,      only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :blogs,         except: :index do
    resources :comments,    only: [:new, :create, :destroy]
  end
  resources :tags,          only: :show
  resources :messages,      only: :create

  root to: 'pages#home'

  get     '/signup'             => 'users#new'
  get     '/signin'             => 'sessions#new'
  delete  '/signout'            => 'sessions#destroy'
  get     '/about'              => 'pages#about'
  get     '/entry/:id'          => 'blogs#show',      as: :entry
  get     '/permalink/:id/'     => 'microposts#show', as: :permalink
  get     '/autocomplete/users'	=> 'users#autocomplete'
end
