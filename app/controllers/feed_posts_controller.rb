class FeedPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_users_feed


  def index
    if current_user.followings.exists?
      @posts = Post.where(user_id: current_user.followings.pluck(:id)).order(created_at: :desc)
    else
      Post.none
    end
    render "feed_posts/index"
  end

  def load_users_feed
    @users = User.where(id: current_user.followings)
  end
end