class GetTweetsController < ApplicationController
  def index
    response = HTTP.get("https://api.twitter.com/2/users/1692561577/tweets?max_results=100")
    data = response.data
    return data
  end
end
