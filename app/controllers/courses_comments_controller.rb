class CoursesCommentsController < CommentsController
  protected
  
    def find_commentable
      @commentable = Course.find(params[:course_id])
    end
end
