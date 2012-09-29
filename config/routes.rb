Socialrails::Application.routes.draw do

  resources :users do
      member do
      get :following, :followers
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy] do
    member do
      get :likes, :liked
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create]

  root to: 'static_pages#home'

  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  
  match '/connect', to: 'static_pages#connect'
  match '/updates', to: 'static_pages#updates'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
end
