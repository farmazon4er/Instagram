class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :load_user
  before_action :load_post

  def index
    @comments = @post.comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to user_post_path(@user, @post), flash: { success: "Comment was add" }
    else
      render :new, flash: { alert: "Some error occured" }
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to action: :index
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_text)
  end

  def load_user
    @user = User.find(params[:user_id])
  end

  def load_post
    @post = Post.find(params[:post_id])
  end
end