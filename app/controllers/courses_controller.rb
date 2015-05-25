class CoursesController < ApplicationController
  before_action :require_user

  def index
    @courses = CourseSummary.includes(:term).order(:name).page(params[:page]).per(50)
  end

  def show
    @course = Course.includes(:subject, sections: [:instructors, :course, :term]).find(params[:id])
  end
end
