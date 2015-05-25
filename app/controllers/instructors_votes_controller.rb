class InstructorsVotesController < VotesController
  protected
  
    def find_voteable
      @voteable ||= Instructor.find(params[:instructor_id])
    end
end