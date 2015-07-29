class CoursesController < ApplicationController
  before_filter :require_user
  
  def index
    @subjects = Subject.all
    @terms = Term.all
    @term = @terms.first
    if params.has_key?(:term_id)
      term_id = params[:term_id].to_i
      @term = @terms.find { |t| t.id == term_id } || @term
    end
    @courses = Course.summary({ :page => params[:page], :per_page => 25, :term => @term })
  end

  def show
    @terms = Term.all
    @term = params.has_key?(:term_id) ? @terms.find { |t| t.id == params[:term_id].to_i } || @terms.first : @terms.first
    @course = Course.find(params[:id], :include => [:subject])
    @instructors = Instructor.by_term_and_course(@term, @course)
    @sections = @course.sections.by_term(@term).find(:all, :include => [:instructor])
    @comments = @course.comments.find(:all, :include => :user)
    @comment = @course.comments.build
  end
end
