class Comment < ActiveRecord::Base
  default_scope :order => 'comments.id'
  
  belongs_to :user
  belongs_to :commentable, :polymorphic => true, :counter_cache => true
  
  validates_presence_of :content
end
