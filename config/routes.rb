Rails.application.routes.draw do

  root "movies#index"
  
  resources :genres

  resources :users
  get "signup" => "users#new"

  

  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy] # generate only the needed routes
  end
  get "movies/filter/:filter" => "movies#index", as: :filter_movies

  get "signin" => "sessions#new"
  resource :session, only:[:create, :new, :destroy]


end

# can access routes through the browser: localhost:3000/rails/info/routes
# can access routes through rails console: rails routes
