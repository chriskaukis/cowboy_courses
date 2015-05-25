class CoursesVotesController < VotesController
  protected
    
    def find_voteable
      @voteable ||= Course.find(params[:course_id])
    end
end