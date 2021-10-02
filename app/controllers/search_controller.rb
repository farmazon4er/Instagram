class SearchController < ApplicationController

  def index
    if params[:query].present?
      @users = User.search_by_user(params[:query]).page(params[:page])
    else
      @users = User.page(params[:page])
    end
  end

end