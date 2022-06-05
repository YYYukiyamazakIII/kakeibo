Rails.application.routes.draw do
  devise_for :users
  root to: 'expenses#index'
  resources :expenses, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :tweets do
    resources :comments, only: [:create, :destroy]
    resources :good_tweets, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
end
