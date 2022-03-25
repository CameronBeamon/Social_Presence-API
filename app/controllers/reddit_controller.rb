class RedditController < ApplicationController
  before_action :authenticate_user

  def index
    first_response = HTTP
      .auth("Bearer #{params["access_token"]}")
      .get("https://oauth.reddit.com/api/v1/me")
    user = JSON.parse(first_response)["subreddit"]["display_name"]
    user = user.split(//)
    user.delete_at(0)
    user.delete_at(0)
    user = user.join
    @username = user

    response = HTTP.get("https://www.reddit.com/user/#{user}/.json")
    render json: JSON.parse(response)
  end

  def auth
    response = HTTP
      .basic_auth(:user => "#{Rails.application.credentials.reddit_client_id}", :pass => "#{Rails.application.credentials.reddit_secret}")
      .post("https://www.reddit.com/api/v1/access_token?", :params => { :grant_type => "authorization_code", :code => "#{params[:code]}", :redirect_uri => "https://cosmic-naiad-083ba7.netlify.app/auth_reddit" })
    render json: JSON.parse(response)
    # render json: { message: params[:code] }
  end

  def create
    response = HTTP
      .auth("Bearer #{params["access_token"]}")
      .post("https://oauth.reddit.com/api/submit?title=#{params["title"]}&text=#{params["text"]}&kind=self&sr=#{@username}")

    render json: JSON.parse(response)
  end
end
