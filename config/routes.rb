Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post "/sessions" => "sessions#create"
  post "/users" => "users#create"
  get "/all_tweets" => "tweets#index"
  get "/all_reddit" => "reddit#index"
  get "/all_tweets/:id" => "tweets#show"
  post "/authorize" => "tweets#authorize"
  post "/authorize_reddit" => "reddit#auth"
  # Defines the root path route ("/")
  # root "articles#index"
end
