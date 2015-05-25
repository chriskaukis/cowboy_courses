# class SectionsScraperJob < ApplicationJob
#   queue_as :default

#   def perform(*args)
#     # Do something later
#   end
# end

class SectionsScraperJob
  attr_accessor :course

  def initialize(course)
    self.course = course
  end

  def perform
    sections = CowboyCoursesScraper::SectionsScraper.new.scrape(course)
    sections.each do |section|
    	# Enqueue to save to the database. 
    	Delayed::Job.enqueue(SaveSectionJob.new(section))
    end
  end
end