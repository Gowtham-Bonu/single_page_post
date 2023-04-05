Rails.application.routes.draw do
  root "posts#index"
  get "explore" => "posts#explore", as: 'explore'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :posts
  
end
