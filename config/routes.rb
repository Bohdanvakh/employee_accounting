Rails.application.routes.draw do
  resources :positions
  resources :employees
  resources :departments
  resources :employees do
    resources :position_histories, only: [:new, :create, :edit, :update]
  end
  resources :employees do
    resources :vacations, only: [:new, :create]
  end
end
