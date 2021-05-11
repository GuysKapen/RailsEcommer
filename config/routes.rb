# frozen_string_literal: true
Rails.application.routes.draw do
  resources :orders do
    collection do
      get :shopping_cart
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
      post :quick_view
      post :update_form_add_to_cart
    end

    collection do
      post :save_attributes
      post :create_variations_from_attrs
      post :change_product_form
      post :add_attributes_input
    end
  end
  resources :user do
    member do
      post :add_to_cart
      # put :save_scheduling
    end
  end
  resources :user, collection: {add_to_cart: :post}
  post 'cart/view_cart', controller: 'cart', action: 'view_cart'

  resources :cart do
    # member do
    #   post :show_cart_popup
    # end
  end
  devise_for :users do
    get '/users/sign_out' => 'devise/session#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
