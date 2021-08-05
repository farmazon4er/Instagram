class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_user

  def index
    @posts = @user.posts
  end

  def show
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = @user
    if @post.save
      redirect_to user_post_path(@user, @post), flash: { success: "Post was add" }
    else
      render :new, flash: { alert: "Some error occured" }
    end
  end

  def edit
    @post = @user.posts.find(params[:id])
  end

  def update
    @post = @user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to user_post_path(@user, @post), flash: { success: "Post was update"}
    else
      render :edit, flash: { alert: "Some error occured" }
    end
  end

  def destroy
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_to action: :index
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end

  def load_user
    @user = User.find(params[:user_id])
  end

end
