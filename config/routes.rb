Socialrails::Application.routes.draw do
  resources :users do
    member do
      get :following, :followers, :replies
    end
  end
  resources :sessions, :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :show, :destroy]
  resources :opinions, :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :captchas, :except => [:edit, :update]

  root :to => 'static_pages#home'

  get    '/signup'  => 'users#new'
  get    '/signin'  => 'sessions#new'
  delete '/signout' => 'sessions#destroy'
  get    '/about'   => 'static_pages#about'
end
