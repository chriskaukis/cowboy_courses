class SearchController < ApplicationController
  before_filter :require_user
  
  def index
    @q = params[:q]
    @search = []
  end
end
