Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post "/sessions" => "sessions#create"
  post "/users" => "users#create"

  post "/authorize" => "tweets#authorize"
  get "/all_tweets" => "tweets#index"
  get "/all_tweets/:id" => "tweets#show"
  post "/all_tweets" => "tweets#create"
  delete "/all_tweets/:id" => "tweets#destroy"

  post "/authorize_reddit" => "reddit#auth"
  get "/all_reddit" => "reddit#index"
  post "/all_reddit" => "reddit#create"

  # Defines the root path route ("/")
  # root "articles#index"
end
