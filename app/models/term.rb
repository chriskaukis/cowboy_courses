class Term < ActiveRecord::Base
  default_scope :order => 'terms.id DESC', :conditions => { :disabled => false }
  
  named_scope :archived, :conditions => { :disabled => true }
  
  has_many :sections
  has_many :courses, :through => :sections, :uniq => true
  has_many :instructors, :through => :sections, :uniq => true
end
