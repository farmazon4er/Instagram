class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :load_user
  before_action :load_post

  def create
    @like = @post.likes.new(like_params)
    @like.user = current_user
    if @like.save
      redirect_to user_post_path(@user, @post), flash: { success: "Like was add" }
    end
  end

  def destroy
    Like.find_by(user: current_user, post: @post).destroy
    redirect_to user_post_path(@user, @post), flash: { success: "Like was delete" }
  end

  private

  def like_params
    params.permit(:user_id, :post_id)
  end

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_post
    @post = Post.find(params[:post_id])
  end

end