class InstructorChangedNotificationJob < Struct.new(:user_id, :section_id)
  def perform
    user = User.find(user_id)
    section = Section.find(section_id)
    Notifier.deliver_section_instructor_changed(user, section)
  end
end