Socialrails::Application.routes.draw do
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions, :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy] do
    member do
      get :likes, :fans
    end
  end
  resources :opinions, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :messages, :only => [:create]

  root :to => 'static_pages#home'

  get    '/signup' => 'users#new'
  post   '/signin' => 'sessions#new'
  delete '/signout' => 'sessions#destroy'

  get    '/updates' => 'static_pages#updates'
  get    '/about' => 'static_pages#about'
  get    '/contact' => 'static_pages#contact'
  get    '/connect' => 'static_pages#connect', :as => :inbox

end
