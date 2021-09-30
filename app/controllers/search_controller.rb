class SearchController < ApplicationController

  def index
    if params[:query].present?
      @users = User.search_by_user(params[:query])
    else
      @users = User.all
    end
  end

end