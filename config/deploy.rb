require 'lib/capistrano_database'
require 'vendor/plugins/thinking-sphinx/recipes/thinking_sphinx'

set :application, "sissed.com"
set :deploy_to, "/home/chris/#{application}/rails"
set :use_sudo, false
set :scm, :git
set :branch, "master"
set :repository,  "ssh://ckaukis@b3b0p.com/home/ckaukis/git/seats.git"
set :deploy_via, :remote_cache
set :domain, "sissed.com"
set :user, "chris"

role :web, domain
role :app, domain
role :db, domain, :primary => true

default_run_options[:pty] = true

#default_environment["GEM_HOME"] = "$HOME/.gems"
#default_environment["GEM_PATH"] = "$GEM_HOME:/usr/lib/ruby/gems/1.8"
#default_environment["PATH"] = "$PATH:$HOME/.gems/bin"

# If you have previously been relying upon the code to start, stop 
# and restart your mongrel application, or if you rely on the database
# migration code, please uncomment the lines you require below

# If you are deploying a rails app you probably need these:

# load 'ext/rails-database-migrations.rb'
# load 'ext/rails-shared-directories.rb'

# There are also new utility libaries shipped with the core these 
# include the following, please see individual files for more
# documentation, or run `cap -vT` with the following lines commented
# out to see what they make available.

# load 'ext/spinner.rb'              # Designed for use with script/spin
# load 'ext/passenger-mod-rails.rb'  # Restart task for use with mod_rails
# load 'ext/web-disable-enable.rb'   # Gives you web:disable and web:enable

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
# see a full list by running "gem contents capistrano | grep 'scm/'"

namespace :deploy do
  desc "Override restart for Passenger."
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end
end

namespace :delayed_job do
  desc "Stop the delayed_job process"
  task :stop, :roles => :app do
    run "cd #{current_path}; script/delayed_job -e production stop"
  end

  desc "Start the delayed_job process"
  task :start, :roles => :app do
    run "cd #{current_path}; script/delayed_job -e production start"
  end
end

namespace :beta do
  desc "Send a beta invite."
  task :invite, :roles => :app do
    run "cd #{current_path} && rake sissed:beta:invite email=#{email} RAILS_ENV=production"
  end
end

before "before_update_code", "delayed_job:stop"
after "after_update_code", "delayed_job:start"
after "after_update_code", "deploy:update_crontab"
