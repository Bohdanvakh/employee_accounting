Rails.application.routes.draw do
  resources :positions
  resources :employees
  resources :departments
  resources :employees do
    resources :position_histories, only: [:new, :create, :edit, :update]
    resources :vacations, only: [:new, :create]
  end
end
