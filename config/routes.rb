Rails.application.routes.draw do
  resources :merchants, only: [:create, :update, :destroy]
  resources :customers, only: [:index, :show, :create, :update, :destroy]
end
