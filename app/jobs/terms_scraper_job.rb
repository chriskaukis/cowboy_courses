# class TermsScraperJob < ApplicationJob
#   queue_as :default

#   def perform(*args)
#     # Do something later
#   end
# end

class TermsScraperJob
  def perform
    terms = CowboyCoursesScraper::TermsScraper.new.scrape
    terms.each do |t|
      Rails.logger.debug "Scraped Term: #{t.name}"
      Delayed::Job.enqueue(SubjectsScraperJob.new(t))
    end
  end
end