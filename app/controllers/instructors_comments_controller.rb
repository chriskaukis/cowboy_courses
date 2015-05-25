class InstructorsCommentsController < CommentsController
  protected

    def find_commentable
      @commentable = Instructor.find(params[:instructor_id])
    end
end
