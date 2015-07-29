class Notifier < ActionMailer::Base
  def section_status_changed(user, section)
    content_type 'text/plain'
    recipients user.notification_emails
    from SMS_CONFIG['config']['from_address']
    subject "#{section.name} Status Changed"
    body "Status for #{section.name} (#{section.call_number.strip}) changed to #{section.status.strip}"
  end

  def section_instructor_changed(user, section)
    content_type 'text/plain'
    recipients user.notification_emails
    from SMS_CONFIG['config']['from_address']
    subject "#{section.name} Instructor Changed"
    body "Instructor for #{section.name} (#{section.call_number}) changed to #{!section.instructor.nil? ? section.instructor.name : 'unknown'}"
  end
  
  def beta_key(email, beta_key)
    content_type 'text/plain'
    recipients email
    from FROM_EMAIL
    subject "sissed.com Beta"
    body :email => email, :beta_key => beta_key
  end
  
  def api_key(user)
    content_type 'text/plain'
    recipients user.email
    from FROM_EMAIL
    subject 'sissed.com API Key'
    body %Q{This is your API Key for sissed.com (don't lose it): #{user.api_key}}
  end
    
  def admin_message(sub, msg)
    content_type 'text/plain'
    recipients ADMIN_EMAIL
    from FROM_EMAIL
    subject sub
    body msg
  end
end
