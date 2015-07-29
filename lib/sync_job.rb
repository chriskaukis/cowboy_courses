class SyncJob < Struct.new(:term_id, :course_id)
  def perform
    term = Term.find_by_id(term_id)
    subject = Subject.find_by_id(course_id)
    puts term.inspect
    puts subject.inspect
    Scrubber.process_courses_and_sections_for_term_and_subject(term, subject)
  end
end