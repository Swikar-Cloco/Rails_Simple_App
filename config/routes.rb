Rails.application.routes.draw do
  resources :artists

  resources :articles, only: [:show, :index]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  
  
  #root 'application#testMethod'

  #root 'controller#method/action'
  # or
  # request_type 'url_endpoint', to: 'controller#method/action'

  root 'pages#home'
  get 'about', to: 'pages#about'

  #don't implement like this as this does not follow the convention for naming but it works
  get 'swikar', to: 'pages#testforswikar'

  # Defines the root path route ("/")
  # root "posts#index"
end
