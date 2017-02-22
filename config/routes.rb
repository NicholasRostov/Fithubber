Rails.application.routes.draw do
 
  # sign up routes
 get "/signup", to: "users#new"
 post "/users", to: "users#create"

 # user log in
 get "/login", to: "sessions#new"
 post "/login", to: "sessions#create"
 get "/logout", to: "sessions#destroy"

 # User edit routes
  get "/users/:id/edit", to: "users#edit"
 patch"/products/:id", to: "products#update"

end
