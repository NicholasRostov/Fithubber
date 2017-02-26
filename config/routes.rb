Rails.application.routes.draw do
 
 # account route
 get "/account", to:"users#show"


  # sign up routes
 get "/signup", to: "users#new"
 post "/users", to: "users#create"

 # user log in
 get "/login", to: "sessions#new"
 post "/login", to: "sessions#create"
 get "/logout", to: "sessions#destroy"

 # User edit routes
  get "/users/:id/edit", to: "users#edit"
 patch"/users/:id", to: "users#update"

 # Data routes
  get "/data/index", to:"fitness_data#index"
  get "/data/new", to: "fitness_data#new"
  post "/data", to: "fitness_data#create"
  get "/data/:id/edit", to: "fitness_data#edit"
  patch "/data/:id", to: "fitness_data#update"

  # membership route
  post "/membership", to: "memberships#create"

 # activity route
  post "/activity", to: "activities#create"

  # fitbit
  get 'fitbit/:resource/:date.json' => 'fitbit_auth#data_request'
  get '/users/auth/:provider', to: 'omniauthcallbacks#passthru'
  post '/users/auth/:provider', to: 'omniauthcallbacks#passthru'
  get '/users/auth/fitbit/callback', to: 'omniauthcallbacks#fitbit'
end
