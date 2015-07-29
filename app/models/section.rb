class Section < ActiveRecord::Base
  OPEN = 'open'
  CLOSED = 'closed'
  CANCELLED = 'cancelled'
  UNLIMITED = 'unlimited'
  
  named_scope :by_term, lambda { |term| { :conditions => ['terms.id = ?', term.id], :include => [:term] } }
  
  belongs_to :instructor
  belongs_to :course
  belongs_to :term
  has_many :subscriptions
  has_many :users, :through => :subscriptions
  
  after_update :send_notifications

  def self.statuses
    return [OPEN, CLOSED, CANCELLED, UNLIMITED]
  end

  def self.count_by_term(term)
    count({ 
      :conditions => ['term_id = ?', term.id], 
      :distinct => true, 
      :select => 'sections.id' 
    })
  end

  protected
  
    def send_notifications
      if status_changed?
        self.users.find(:all, :conditions => { :status_notification => true }).each do |u|
          Delayed::Job.enqueue(StatusChangedNotificationJob.new(u.id, self.id), 100)
        end
      end
      
      if self.instructor_id_changed?
        self.users.find(:all, :conditions => { :instructor_notification => true }).each do |u|
          Delayed::Job.enqueue(InstructorChangedNotificationJob.new(u.id, self.id), 100)
        end
      end
    end
end
