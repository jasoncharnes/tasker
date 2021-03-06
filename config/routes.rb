Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: "lists#index"
  resources :lists, only: [:new, :create, :destroy] do
    resources :tasks, only: :show do
      resources :comments, only: :create
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
