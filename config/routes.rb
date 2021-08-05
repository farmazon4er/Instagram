Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:show, :edit, :update] do
    resources :posts
  end

  devise_scope :user do
    get "/" => "devise/sessions#new"
  end

end
