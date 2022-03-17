class TweetsController < ApplicationController
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
      # .auth("Bearer #{params["access_token"]}")
      # .get("https://api.twitter.com/2/tweets?ids=#{user_info["data"]["id"]}&tweet.fields=created_at&expansions=author_id&user.fields=created_at")
      data = response
      render json: JSON.parse(data)
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
    pp Rails.application.credentials
    response = HTTP
    # .auth("Basic VFRkcFNrYzJWV3BVUTJST2IwVlJiRWxTV1ZvNk1UcGphUTpPZXpmYUY5alZHX1VKbTNsbXY1TjBvNWxOM3ZBRnZ5SFhoNlRiVkVGVWJWTHlFSmFsVA==")
      .headers(:ContentType => "application/x-www-form-urlencoded", :Authorization => "Basic #{Rails.application.credentials.twitter_basic_auth}")
      .post("https://api.twitter.com/2/oauth2/token",
            :form => { :code => params["code"],
                       :grant_type => "authorization_code",
                       :client_id => "#{Rails.application.credentials.twitter_client_id}",
                       :redirect_uri => "http://localhost:8080",
                       :code_verifier => "challenge" })
    render json: JSON.parse(response.body)
  end

  def update
  end

  def delete
  end
end
