# class CoursesScraperJob < ApplicationJob
#   queue_as :default

#   def perform(*args)
#     # Do something later
#   end
# end

class CoursesScraperJob
  attr_accessor :subject

  def initialize(subject)
    self.subject = subject
  end

  def perform
    courses = CowboyCoursesScraper::CoursesScraper.new.scrape(subject)
    courses.each do |c|
      puts "Scraped Course: #{c.name}"
      Delayed::Job.enqueue(SectionsScraperJob.new(c))
    end
  end
end