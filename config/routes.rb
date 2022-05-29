Rails.application.routes.draw do
  devise_for :users
  root to: 'expenses#index'
  resources :expenses, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :tweets, only: [:index, :new, :create, :show] do
    collection do
      get 'search'
    end
  end
end
