class VotesController < ApplicationController
  before_filter :require_user
  before_filter :find_voteable
  
  def up
    @vote = Vote.up!(@voteable, current_user)
    flash[:notice] = "Up voted #{@voteable.name}"
    redirect_to params[:redirect_to] || url_for(@voteable)
  end
  
  def down
    @vote = Vote.down!(@voteable, current_user)
    flash[:notice] = "Down voted #{@voteable.name}"
    redirect_to params[:redirect_to] || url_for(@voteable)
  end
end