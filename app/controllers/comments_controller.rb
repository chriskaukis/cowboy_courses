class CommentsController < ApplicationController
  before_filter :require_user
  # Just be sure to implement this method and 
  # set the @commentable instance variable and 
  # things will be fine.
  before_filter :find_commentable
  
  def index
    @comments = @commentable.comments.find(:all, :include => :user)
    render :template => 'comments/index'
  end

  def new
    @comment = @commentable.comments.build({ :user => current_user })
    render :template => 'comments/new'
  end

  def create
    @comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:notice] = 'Successfully added comment'
      redirect_to polymorphic_url([@commentable], :anchor => "comment_#{@comment.id}")
    else
      render :template => 'comments/new'
    end
  end

  def edit
    @comment = @commentable.comments.find(params[:id], :include => :user)
    render :template => 'comments/edit'
  end

  def update
    @comment = @commentable.comments.find(params[:id], :include => :user)
    if @comment.update_attributes(params[:comment])
      flash[:notice] = 'Successfully updated comment'
      redirect_to polymorphic_url(@commentable, :anchor => "comment_#{@comment.id}")
    else
      render :template => 'comments/edit'
    end
  end

  def show
    @course = Course.find(params[:course_id])
    @comment = @commentable.comments.find(params[:id])
    render :template => 'comments/show'
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = 'Successfully deleted comment'
    redirect_to url_for(@commentable)
  end
end
