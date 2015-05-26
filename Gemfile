source 'https://rubygems.org'

gem 'dotenv-rails'

gem 'rails', github: "rails/rails"
gem 'arel', github: "rails/arel"

# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', github: "rails/coffee-rails"

gem 'bootstrap-sass', '~> 3.3.4'
gem 'font-awesome-sass', '~> 4.3.0'
gem 'zeroclipboard-rails'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
gem 'unicorn'

# Needed for scraping.
gem 'mechanize'

gem 'kaminari'

# If we want to use Resque.
# gem 'resque'
# gem 'resque-scheduler'

# If we want to use DelayedJob.
# In config/application.rb: config.active_job.queue_adapter = :delayed_job
# rails generate delayed_job:active_record
gem 'delayed_job_active_record'

# To run delayed jobs as daemon(s).
gem 'daemons'

gem 'twilio-ruby'

# Use Capistrano for deployment
group :development do
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  # gem 'capistrano-unicorn'
  gem 'capistrano3-unicorn'
  gem 'capistrano3-delayed-job'
  # gem 'capistrano-rvm'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', github: "rails/web-console"
end
