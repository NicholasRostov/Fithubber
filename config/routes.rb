Rails.application.routes.draw do
 
  root to: "/users/"

 
 # get "users/new", to: "users#new"
 # post "/users", to: "users#create"
 # get "/users/:id", to: "users#show"
 # get "/users/:id/edit", to: "users#edit"
 # patch"/users/:id", to: "users#update"
 # delete "/users/:id", to:"users#destroy"

 # sign up routes
 get "/signup", to: "users#new"
 post "/users", to: "users#create"

 # user log in
 get "/login", to: "sessions#new"
 post "/login", to: "sessions#create"
 get "/logout", to: "sessions#destroy"
end
