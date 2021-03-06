# config valid only for current version of Capistrano
lock '3.4.0'

set :rbenv_type, :user
set :rbenv_ruby, '2.2.2'

set :application, 'cowboy_courses'
set :repo_url, 'https://github.com/chriskaukis/cowboy_courses.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, 'master'

set :stages, ['production']

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/chris/apps/cowboy_courses'
set :user, 'chris'
set :use_sudo, false
set :rails_env, 'production'
set :deploy_via, :copy

set :ssh_options, { :forward_agent => true, :port => 1981 }

set :keep_releases, 5

set :pty, true

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
# set :linked_files, %w{config/database.yml .rbenv-vars}
set :linked_files, %w{config/database.yml config/secrets.yml .env}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :delayed_job_args, '-n 10'
set :unicorn_config_path, 'config/unicorn.rb'

namespace :deploy do

  after 'deploy:publishing', 'deploy:restart'
  namespace :deploy do
    task :restart do
      invoke 'unicorn:restart'
      invoke 'delayed_job:restart'
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
