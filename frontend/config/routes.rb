Spree::Core::Engine.routes.draw do

  root :to => 'home#index'

  resources :users, :only => [:show]

  devise_scope :users do
    get '/login' => 'users/sessions#new', :as => :login
    get '/signup' => 'users/registrations#new', :as => :signup
    get '/password/recover' => 'users/passwords#new', :as => :recover_password
    get '/password/change' => 'users/passwords#edit', :as => :edit_password
  end

  devise_for :users,
    class_name: 'Spree::User',
    controllers: {
      sessions: 'spree/users/devise/sessions',
      registrations: 'spree/users/devise/registrations',
      passwords: 'spree/users/devise/passwords'
    }
  
  resources :products
  resources :stockpiles do
    member do
      get :edit_address
      get :edit_picture
      get :edit_seller_offer
    end
    resources :addresses, only: [:new, :create], controller: 'stockpiles/addresses'
  end
  resources :listings do
    resources :shops, only: [:new, :create], controller: 'listings/shops'
    resources :offers, only: [:create, :index], controller: 'listings/offers'
    resources :stockpiles, only: [:new, :create], controller: 'listings/stockpiles'
  end
  resources :offers, only: [:show, :edit, :update, :destroy] do
    member do
      post :accept
      get :counter
    end
    resources :comments, only: [:new, :create], controller: 'offers/comments' do
      collection do
        get :demand
      end
    end
    resources :addresses, only: [:create, :new], controller: 'offers/addresses'
    resources :users, only: [:create, :new], controller: 'offers/users'
  end
  resources :shops, :only => [:show] do
    member do
      get :rating
    end
  end

  get '/locale/set', :to => 'locale#set'

  # non-restful checkout stuff
  patch '/checkout/update/:state', :to => 'checkout#update', :as => :update_checkout
  get '/checkout/:state', :to => 'checkout#edit', :as => :checkout_state
  get '/checkout', :to => 'checkout#edit' , :as => :checkout

  populate_redirect = redirect do |params, request|
    request.flash[:error] = Spree.t(:populate_get_error)
    request.referer || '/cart'
  end

  get '/orders/populate', :via => :get, :to => populate_redirect
  get '/orders/:id/token/:token' => 'orders#show', :as => :token_order

  resources :orders do
    post :populate, :on => :collection
  end

  get '/cart', :to => 'orders#edit', :as => :cart
  patch '/cart', :to => 'orders#update', :as => :update_cart
  put '/cart/empty', :to => 'orders#empty', :as => :empty_cart

  # route globbing for pretty nested taxon and product paths
  get '/t/*id', :to => 'taxons#show', :as => :nested_taxons

  get '/unauthorized', :to => 'home#unauthorized', :as => :unauthorized
  get '/content/cvv', :to => 'content#cvv', :as => :cvv
  get '/content/*path', :to => 'content#show', :as => :content
end
