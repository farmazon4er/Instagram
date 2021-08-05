class FollowsController < ActionController::Base
  before_action :authenticate_user!

  def create
    follower_user = current_user
    following_user = User.find(params[:following_id])

    Follow.create(follower: follower_user, following: following_user)

    redirect_to user_followers_path(current_user)
  end
end