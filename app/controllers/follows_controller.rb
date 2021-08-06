class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    follower_user = current_user
    following_user = User.find(params[:following_id])

    Follow.create(follower: follower_user, following: following_user)

    redirect_to user_followings_path(current_user)
  end

  def destroy
    follower_user = current_user
    following_user = User.find(params[:following_id])

    Follow.find_by(follower: follower_user, following: following_user).destroy

    redirect_to user_followings_path(current_user)
  end

end