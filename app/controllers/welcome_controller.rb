class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @tweets = current_user.feed
    else
      @tweets = Tweet.all
    end
    render template: "tweets/index"
  end
end
