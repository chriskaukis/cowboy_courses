class SissedController < ApplicationController
  def index
    if logged_in?
      @instructors = Instructor.top(10).find(:all)
      @courses = Course.top(10).find(:all)
    else
      render :action => :home
    end
  end
end
