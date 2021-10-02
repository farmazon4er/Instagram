class UsersController < ApplicationController

  before_action :authenticate_user!, only: %i[edit update]

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_update_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

    private

  def user_update_params
    params.require(:user).permit(:name, :bio, :image)
  end

end