Rails.application.routes.draw do
  root to: 'users#new'
  resources :posts do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users do 
    resources :favorites, only: [:index]
    resources :relationships, only: [:create, :destroy]
    get :follows, on: :member 
    get :followers, on: :member 
  end
  resources :favorites, only: [:create, :destroy]
 mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
