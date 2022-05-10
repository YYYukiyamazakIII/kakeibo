Rails.application.routes.draw do
  root to: "expenses#index"
  resources :expenses, only: [:index, :create, :show]
end
