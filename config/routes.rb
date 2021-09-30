Rails.application.routes.draw do

  devise_for :users
  resources :users, only: %i[show edit update index] do
    resources :posts, only: %i[show new create update edit destroy] do
      resources :comments
      resources :likes, only: %i[create destroy]
    end
    resources :followers, only: :index
    resources :followings, only: :index
  end

  resources :follows, only: %i[create destroy]
  resources :feed_posts, only: [:index]
  resources :search, only: [:index]

  devise_scope :user do
    get "/" => "devise/sessions#new"
  end

end
