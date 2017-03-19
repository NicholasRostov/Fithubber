Rails.application.routes.draw do
 
 devise_for :fit_users, :controllers => { :omniauth_callbacks => "fit_users/omniauth_callbacks" }
 root to: "users#new"
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
  get "/fitbit_auth", to: "fitbit_auth#index"
  post "/auth/fitbit", to: "fitbit_auth#make_request"
  get "/auth/fitbit/callback", to: "fitbit_auth#get_response"

  # photo routes
  post "/photos", to: "photos#create"
end
