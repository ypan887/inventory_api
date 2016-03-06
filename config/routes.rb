Rails.application.routes.draw do
  resources :supplies, only: [:create, :update, :destroy]
  resources :categories, only: [:create, :update, :destroy]
  resources :merchants, only: [:create, :update, :destroy]
  resources :customers, only: [:index, :show, :create, :update, :destroy]
end
