Socialrails::Application.routes.draw do
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions, :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :show, :destroy]
  resources :messages, :only => [:create]
  resources :opinions, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]

  root :to => 'static_pages#home'

  get    '/signup' => 'users#new'
  get    '/signin' => 'sessions#new'
  delete '/signout' => 'sessions#destroy'

  get    '/updates' => 'static_pages#updates'
  get    '/about' => 'static_pages#about'
  get    '/contact' => 'static_pages#contact'
  get    '/connect' => 'static_pages#connect', :as => :inbox
end
