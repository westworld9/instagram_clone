Rails.application.routes.draw do
  root to: 'users#new'
  resources :posts
  resources :favorites, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users do 
    resources :relationships, only: [:create, :destroy]
    get :follows, on: :member 
    get :followers, on: :member 
  end
 mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
