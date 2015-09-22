class FollowingsController < ApplicationController
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to controller: :users, action: :show, username: user.username
  end

  def destroy
    user = Following.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to controller: :users, action: :show, username: user.username
  end
end
