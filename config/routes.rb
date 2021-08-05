Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show, :edit, :update, :index] do
    resources :posts
    resources :followers, only: :index
    resources :followings, only: :index
  end
  resources :follows, only: [:create]
  devise_scope :user do
    get "/" => "devise/sessions#new"
  end

end
