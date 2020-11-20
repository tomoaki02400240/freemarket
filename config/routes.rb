Rails.application.routes.draw do
  get 'markets/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'markets#index',as: :top
  get 'markets/:id', to: 'markets#show', as: :markets_show
  get 'markets/:id/payment', to: 'markets#payment', as: :payment
  post 'markets/:id/payment',to: 'markets#payment_process'
  
  get 'users/profiles/', to: 'users#profiles', as: :profiles
  get 'users/sign_up', to: 'users#sign_up', as: :sign_up
  post 'users/sign_up_process', to: 'users#sign_up_process'
  get 'users/sign_in', to: 'users#sign_in', as: :sign_in
  post 'users/sign_in_process', to: 'users#sign_in_process'
  get 'users/:id/sign_out', to: 'users#sign_out', as: :sign_out
  get 'users/profiles/:id/edit', to: 'users#edit', as: :profiles_edit
  post 'users/profiles/:id/update', to: 'users#update', as: :update
  get 'users/:id/likes', to: 'users#like', as: :users_likes
  get 'users/like', to: 'users#moment', as: :moment
  
  namespace :users do
    get '/products', to: 'products#index', as: :products
    get 'products/new', to: 'products#new', as: :new_products
    get 'products/:id', to: 'products#show', as: :product
    post 'products/create', to: 'products#create'
    get 'products/:id/edit', to: 'products#edit', as: :edit_products
    post 'product/:id/uepdate', to: 'products#update', as: :update_products
    delete 'products/:id/destroy', to: 'products#destroy'
    
  end
end
