Rails.application.routes.draw do
  devise_for :users
  root to: 'expenses#index'
  resources :expenses, only: %i[index new create]
end
