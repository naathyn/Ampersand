Socialrails::Application.routes.draw do

  resources :users do
    member do
      get :following, :followers, :fans
    end
  end

  match '/signup', to: 'users#new'
  match '/users/:id', to: 'users#show'

  resources :relationships, only: [:create, :destroy]
  resources :microposts, only: [:create, :destroy] do
    member do
      get :likes
    end
  end
  resources :opinions, only: [:create, :destroy]
  resources :messages, only: [:create]
  resources :sessions, only: [:new, :create, :destroy]

  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  root to: 'static_pages#home'

  match '/updates', to: 'static_pages#updates'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/connect', to: 'static_pages#connect'
end
