# class SaveSectionJob < ApplicationJob
#   queue_as :default

#   def perform(*args)
#   # Do something later
#   end
# end

class SaveSectionJob
  attr_accessor :section

  def initialize(section)
    self.section = section
  end

  def perform
    ActiveRecord::Base.transaction do
      begin
        term = Term.find_or_initialize_by(identifier: section.course.subject.term.id) do |t|
          t.name = section.course.subject.term.name
        end
        term.save!

        subject = Subject.find_or_initialize_by(identifier: section.course.subject.id) do |s|
          s.name = section.course.subject.name
        end
        subject.save!

        course = Course.find_or_initialize_by(identifier: section.course.id) do |c|
          c.name = section.course.name
          c.subject = subject
        end
        course.save!

        record = Section.find_or_initialize_by(identifier: section.id, term: term, course: course) do |s|
          s.name = section.name
          s.call_number = section.call_number
          s.status = section.status
          s.open_seats = section.open_seats
          s.total_seats = section.total_seats
          s.days = section.days
          s.starts_at = section.starts_at
          s.ends_at = section.ends_at
          s.course = course
          s.term = term

          section.instructors.each do |instructor|
            Instructor.find_or_initialize_by(identifier: instructor) do |i|
              i.name = instructor
              i.sections << s
            end
          end

          # Check for changes and queue job to notify user.
          if record.status_changed? && (record.status_was('cancelled') || record.status_was('closed')) && record.status.eql?('open')
            Delayed::Job.enqueue(SectionStatusChangedJob.new(record))
          end
        end
        record.save!
      rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
        raise ActiveRecord::Rollback 
      end
    end
  end
end