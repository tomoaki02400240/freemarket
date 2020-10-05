Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'users#profiles'
  get 'profiles', to: 'users#profiles', as: :profiles
  
end
