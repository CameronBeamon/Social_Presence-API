class RedditController < ApplicationController
  def index
    first_response = HTTP
      .auth("Bearer #{params["access_token"]}")
      .get("https://oauth.reddit.com/api/v1/me")
    user = JSON.parse(first_response)["subreddit"]["display_name"]
    user = user.split(//)
    user.delete_at(0)
    user.delete_at(0)
    user = user.join

    response = HTTP.get("https://www.reddit.com/user/#{user}/.json")
    render json: JSON.parse(response)
  end

  def auth
    response = HTTP
      .basic_auth(:user => "#{Rails.application.credentials.reddit_client_id}", :pass => "#{Rails.application.credentials.reddit_secret}")
      .post("https://www.reddit.com/api/v1/access_token?", :params => { :grant_type => "authorization_code", :code => "#{params[:code]}", :redirect_uri => "http://localhost:8080/auth_reddit" })
    render json: JSON.parse(response)
    # render json: { message: params[:code] }
  end
end
