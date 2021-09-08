# frozen_string_literal: true
Rails.application.routes.draw do
  resources :orders do
    collection do
      get :shopping_cart
      post :create_order_old_info
      post :remove_product_cart_from_cart
    end
  end
  get 'cart/index'
  mount Ckeditor::Engine => '/ckeditor'
  get 'contact' => 'contact#index'
  get 'about' => 'about#index'
  root to: 'home#index'

  post     'new_product' => 'products#create'
  get      'new_product' => 'products#new'
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
      post :filter_by_price
      post :add_comment
      post :add_reply
      post :show_replies
      post :add_reply_form
      post :toggle_like
    end
  end
  resources :user do
  end
  resources :comment
  resources :user, collection: {add_to_cart: :post}

  resources :cart do
    collection do
      post :modify_qty
      post :view_cart
    end
  end
  devise_for :users do
    get '/users/sign_out' => 'devise/session#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
