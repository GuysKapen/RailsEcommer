# frozen_string_literal: true
Rails.application.routes.draw do
  resources :orders do
    collection do
      get :checkout
    end
  end
  get 'cart/index'
  mount Ckeditor::Engine => '/ckeditor'
  get 'contact' => 'contact#index'
  get 'about' => 'about#index'
  root to: 'home#index'
  resources :products do
    member do
      post :add_to_cart
      post :add_to_wishlist
    end
  end
  resources :user do
    member do
      post :add_to_cart
      # put :save_scheduling
    end
  end
  resources :user, collection: {add_to_cart: :post}
  resources :cart
  devise_for :users do
    get '/users/sign_out' => 'devise/session#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
