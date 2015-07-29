class Subscription < ActiveRecord::Base
  default_scope :order => 'subscriptions.id DESC'
  
  belongs_to :user
  belongs_to :section
  
  validates_presence_of :section_id, :user_id
  validates_uniqueness_of :section_id, :scope => :user_id
end
