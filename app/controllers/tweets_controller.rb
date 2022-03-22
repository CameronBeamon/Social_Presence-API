class TweetsController < ApplicationController
  before_action :authenticate_user

  def index
    if params["access_token"]
      first_response = HTTP
        .auth("Bearer #{params["access_token"]}")
        .get("https://api.twitter.com/2/users/me")
      user_info = JSON.parse(first_response.body)
      user_id = user_info["data"]["id"]
      response = HTTP
        .auth("Bearer #{Rails.application.credentials.twitter_bearer}")
        .get("https://api.twitter.com/2/users/#{user_id}/tweets?max_results=10")
      render json: JSON.parse(response)
    else
      render json: [message: "Failed"]
    end
  end

  def show
    response = HTTP
      .auth("Bearer #{Rails.application.credentials.twitter_bearer}")
      .get("https://api.twitter.com/2/tweets/#{params["id"]}")
    render json: JSON.parse(response)
  end

  def authorize
    response = HTTP
      .headers(:ContentType => "application/x-www-form-urlencoded", :Authorization => "Basic #{Rails.application.credentials.twitter_basic_auth}")
      .post("https://api.twitter.com/2/oauth2/token",
            :form => { :code => params["code"],
                       :grant_type => "authorization_code",
                       :client_id => "#{Rails.application.credentials.twitter_client_id}",
                       :redirect_uri => "http://localhost:8080/auth_twitter",
                       :code_verifier => "challenge" })
    render json: JSON.parse(response.body)
  end

  def create
    if params["access_token"] && params["text"]
      response = HTTP
        .headers(:ContentType => "application/json")
        .auth("Bearer #{params["access_token"]}")
        .post("https://api.twitter.com/2/tweets",
              :json => {
                text: params["text"],
              })
      render json: JSON.parse(response)
    else
      render json: { message: "no access token or text" }
    end
  end

  def destroy
    response = HTTP
      .auth("Bearer #{params["access_token"]}")
      .delete("https://api.twitter.com/2/tweets/#{params["id"]}")
    render json: JSON.parse(response)
  end
end
