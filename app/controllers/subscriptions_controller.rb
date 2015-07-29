class SubscriptionsController < ApplicationController
  before_filter :require_user
  
  def index
    @terms = Term.all
    @term = params.has_key?(:term_id) ? @terms.find { |t| t.id == params[:term_id].to_i } || @terms.first : @terms.first
    @subscriptions = current_user.subscriptions.find(:all, 
      :include => [{ :section => [:term, :instructor, { :course => :subject }] }],
      :conditions => ['terms.id = ?', @term.id])
    @courses = @subscriptions.map { |subscription| subscription.section.course }.uniq.sort
    @subjects = @courses.map(&:subject).uniq.sort
    @instructors = @subscriptions.map { |subscription| subscription.section.instructor }.uniq.sort
  end
  
  def create
    begin
      section = Section.find(params[:section_id], :include => :course)
      subscription = current_user.subscriptions.create!(:section => section)
    rescue
      flash[:notice] = "Already subscribed to #{section.name}"
    else
      flash[:notice] = "Subscribed to #{section.name}"
    end
    redirect_to params[:redirect_to] || course_url(section.course)
  end
  
  def destroy
    subscription = current_user.subscriptions.first(:conditions => { :section_id => params[:section_id] })
    if subscription.nil?
      flash[:notice] =  "You aren't subscribed to that"
    else
      subscription.destroy
      flash[:notice] = "Unsubscribed to #{subscription.section.name}"
    end
    redirect_to params[:redirect_to] || subscriptions_url
  end
end
