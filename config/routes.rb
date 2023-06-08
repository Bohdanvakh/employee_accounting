Rails.application.routes.draw do
  root to: "departments#index"

  resources :positions
  resources :employees
  resources :departments

  get "departments/:id/employees_list", to: "departments#employees_list"

  resources :employees do
    resources :position_histories, only: [:new, :create, :edit, :update]
    resources :vacations, only: [:new, :create]
  end
end
