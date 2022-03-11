Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/all_tweets" => "tweets#index"
  get "/all_tweets/:id" => "tweets#show"
  post "/authorize" => "tweets#authorize"
  # Defines the root path route ("/")
  # root "articles#index"
end
