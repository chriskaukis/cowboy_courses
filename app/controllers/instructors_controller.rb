class InstructorsController < ApplicationController 
  before_filter :require_user
  
  def index
    @terms = Term.all
    @term = params.has_key?(:term_id) ? @terms.find { |t| t.id == params[:term_id].to_i } || @terms.first : @terms.first
    @instructors = Instructor.summary({ :page => params[:page], :per_page => 25, :term => @term })
  end
  
  def show
    @terms = Term.all
    @term = params.has_key?(:term_id) ? @terms.find { |t| t.id == params[:term_id].to_i } || @terms.first : @terms.first
    @instructor = Instructor.find(params[:id])
    @subjects = Subject.by_instructor(@instructor)
    @sections = @instructor.sections.find(:all, :include => [:term, { :course => :subject }], :conditions => ['terms.id = ?', @term.id])
    @comments = @instructor.comments.find(:all, :include => [:user])
    @comment = @instructor.comments.build
  end
end
