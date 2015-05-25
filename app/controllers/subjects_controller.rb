class SubjectsController < ApplicationController
  before_filter :require_user
  
  def index
    @terms = Term.all
    @term = @terms.first
    if params.has_key?(:term_id)
      term_id = params[:term_id].to_i
      @term = @terms.find { |t| t.id == term_id } || @term
    end
    @subjects = Subject.summary_by_term(@term)
  end
  
  def show
    @subjects = Subject.all
    @subject = @subjects.find { |s| s.id == params[:id].to_i } || @subjects.first
    @terms = Term.all
    @term = @terms.find { |t| t.id == params[:term_id].to_i } || @terms.first
    @courses = Course.summary({ :page => params[:page], :per_page => 50, :subject => @subject, :term => @term })
  end
end
