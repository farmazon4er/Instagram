Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show, :edit, :update, :index] do
    resources :posts do
      resources :comments
    end
    resources :followers, only: :index
    resources :followings, only: :index
  end

  resources :follows, only: [:create, :destroy]
  resources :feed_posts, only: [:index]

  devise_scope :user do
    get "/" => "devise/sessions#new"
  end

end
