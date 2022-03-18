Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post "/sessions" => "sessions#create"
  post "/users" => "users#create"

  post "/authorize" => "tweets#authorize"
  get "/all_tweets" => "tweets#index"
  get "/all_tweets/:id" => "tweets#show"
  post "/all_tweets" => "tweets#create"
  delete "/all_tweets/:id" => "tweets#destroy"

  get "/all_reddit" => "reddit#index"
  post "/authorize_reddit" => "reddit#auth"
  # Defines the root path route ("/")
  # root "articles#index"
end
