class TweetsController < ApplicationController
  def index
    response = HTTP
      .auth("Bearer AAAAAAAAAAAAAAAAAAAAAPIlYAEAAAAAcl9F%2B2lHdhwOHIV000PTpleFgM4%3DDDgwD0NlzM7mJoZn4M7zewzagbrSe37AW3cBCBCKyW66CcvWaF")
      .get("https://api.twitter.com/2/users/1692561577/tweets?max_results=10")
    data = response
    render json: JSON.parse(data)
  end

  def show
    response = HTTP
      .auth("Bearer AAAAAAAAAAAAAAAAAAAAAPIlYAEAAAAAcl9F%2B2lHdhwOHIV000PTpleFgM4%3DDDgwD0NlzM7mJoZn4M7zewzagbrSe37AW3cBCBCKyW66CcvWaF")
      .get("https://api.twitter.com/2/tweets/#{params["id"]}")
    render json: JSON.parse(response)
  end

  def authorize
    response = HTTP
    # .auth("Basic VFRkcFNrYzJWV3BVUTJST2IwVlJiRWxTV1ZvNk1UcGphUTpPZXpmYUY5alZHX1VKbTNsbXY1TjBvNWxOM3ZBRnZ5SFhoNlRiVkVGVWJWTHlFSmFsVA==")
      .headers(:ContentType => "application/x-www-form-urlencoded", :Authorization => "Basic VFRkcFNrYzJWV3BVUTJST2IwVlJiRWxTV1ZvNk1UcGphUTpPZXpmYUY5alZHX1VKbTNsbXY1TjBvNWxOM3ZBRnZ5SFhoNlRiVkVGVWJWTHlFSmFsVA==")
      .post("https://api.twitter.com/2/oauth2/token",
            :form => { :code => params["code"],
                       :grant_type => "authorization_code",
                       :client_id => "TTdpSkc2VWpUQ2ROb0VRbElSWVo6MTpjaQ",
                       :redirect_uri => "localhost:8080",
                       :code_verifier => "challenge" })
    render json: { message: response, from_back_end: params["code"] }
  end

  def update
  end

  def delete
  end
end
