# class SubjectsScraperJob < ApplicationJob
#   queue_as :default

#   def perform(*args)
#     # Do something later
#   end
# end

class SubjectsScraperJob
  attr_accessor :term

  def initialize(term)
    self.term = term
  end

  def perform
    subjects = CowboyCoursesScraper::SubjectsScraper.new.scrape(term)
    subjects.each do |s|
      Delayed::Job.enqueue(CoursesScraperJob.new(s))
    end
  end
end