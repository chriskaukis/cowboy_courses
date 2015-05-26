desc 'Start scraping.'
task scrape: :environment do
  Delayed::Job.enqueue(TermsScraperJob.new)
end