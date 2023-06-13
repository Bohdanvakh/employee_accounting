Rails.application.routes.draw do
  root to: "departments#index"

  resources :positions
  resources :employees
  resources :departments

  get "departments/:id/employees", to: "departments#employees"

  resources :employees do
    resources :position_histories, only: [:new, :create, :edit, :update]
    resources :vacations, only: [:new, :create]
  end
end
