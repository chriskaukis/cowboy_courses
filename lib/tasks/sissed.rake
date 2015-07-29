namespace :sissed do 
  namespace :beta do
    desc 'Invite a user to the beta.'
    task :invite => :environment do
      unless ENV['email'].blank?
        # BETA_KEY is in config/initializers/app_config.rb
        Notifier.deliver_beta_key(ENV['email'], BETA_KEY)
      else
        puts 'email is required'
      end
    end
  end

  namespace :sis do    
    desc 'Sync with OSU SIS.'
    task :sync => :environment do
      # Notifier.deliver_admin_message('Sync with SIS Started', "Sync with OSU SIS started #{Time.now}")
      Scrubber.process_terms_and_subjects
    end
  end

  namespace :api do
    desc 'Create an API key for the given user given their email.'
    task :create_key => :environment do
      if ENV['email'].blank?
        puts 'email is required.'
      else
        users = User.find(:all, :conditions => { :email => ENV['email'] })
        if users.length > 0
          puts "no users found with email #{ENV['email']}"
        else
          users.each do |u|
            user.enable_api!
            Notifier.deliver_api_key(user)
          end
        end
      end
    end
  end
  
  namespace :db do 
    desc '(Re)build the identifiers for instructors.'
    task :create_instructor_identifiers => :environment do
      Instructor.find(:all).each do |instructor|
        identifier = instructor.name.strip
        identifier.gsub!(/[^-_a-zA-Z0-9]/, '-')
        identifier.gsub!('--', '-')
        instructor.identifier = identifier
        instructor.save(false)
      end
    end
  end
end
