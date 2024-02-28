Rails.application.routes.draw do
  resources :users
  resources :artists

  # resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  #the above line ans the below lines are same. in above we are specifying which routes to use but as we have used every possible usage we can simply write as line below as it would do the same.
  resources :articles

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
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  #don't implement like this as this does not follow the convention for naming but it works
  get 'swikar', to: 'pages#testforswikar'

  # Defines the root path route ("/")
  # root "posts#index"
end
