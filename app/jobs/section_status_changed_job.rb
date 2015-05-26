class SectionStatusChangedJob
  attr_accessor :section_id

  def initialize(section_id)
    self.section_id = section_id
  end

  def perform
    client = Twilio::REST::Client.new(Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token)
    Subscription.includes(:section, :user).where(section_id: self.section_id).each do |subscription|
      UserMailer.delay.section_status_changed(subscription)
      # This is ineficient and ugly. I don't like it. Fix it.
      body = "#{section.name} (call #: #{section.call_number}) changed to #{section.status}"
      message = client.messages.create(from: '+14058808798', to: subscription.user.phone, body: body)
    end
  end
end
