Rails.application.routes.draw do
  devise_for :users
root to: "prototypes#index"
resources :prototypes, only: [ :destroy, :new, :show, :create, :edit, :update ] do
  resources :comments, only: :create
end

  resources :users, only: :show
end

# resources :prototypes do
  # patch :update, on: :member
  # end

