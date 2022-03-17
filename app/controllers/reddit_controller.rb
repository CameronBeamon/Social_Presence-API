class RedditController < ApplicationController
  def index
    response = HTTP.get("https://www.reddit.com/user/TheIsTheNewMe/.json")
    render json: JSON.parse(response)
  end

  def auth
    response = HTTP
      .basic_auth(:user => "W#{Rails.application.credentials.reddit_client_id}", :pass => "#{Rails.application.credentials.reddit_secret}")
      .post("https://www.reddit.com/api/v1/access_token?", :params => { :grant_type => "authorization_code", :code => "#{params[:code]}", :redirect_uri => "http://localhost:8080" })
    render json: JSON.parse(response)
    # render json: { message: params[:code] }
  end

  def get_user_indentity
    response = HTTP
      .headers("Bearer #{params["access_token"]}")
      .get("https://oauth.reddit.com/api/v1/me")
    render json: JSON.parse(response)
  end
end
