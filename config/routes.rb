Rails.application.routes.draw do
  resources :statements, only: [:index]
  resources :shipments, only: [:index, :show, :create, :update, :destroy]

  resources :categories, only: [:index, :create, :update, :destroy] do
    resources :products, only: [:index, :create]
  end

  resources :merchants, only: [:index, :show, :create, :update, :destroy] do
    resources :supplies, only: [:index, :create]
  end

  resources :customers, only: [:index, :show, :create, :update, :destroy] do
    resources :orders, only: [:index, :create]
  end

  resources :orders, only: [:show, :update, :destroy]
  resources :supplies, only: [:show, :update, :destroy]
  resources :products, only: [:show, :update, :destroy]
end
