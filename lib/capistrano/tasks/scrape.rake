namespace :scrape do
  task :start do
   on roles(:all) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'scrape'
        end
      end 
    end
  end
end