class Course < ActiveRecord::Base
  belongs_to :subject
  has_many :sections
  has_many :instructors, -> { uniq }, :through => :sections
  has_many :terms, -> { uniq }, :through => :sections
  has_many :votes, :as => :voteable
  has_many :comments, :as => :commentable

  def score
    ups - downs
  end

  def <=>(course)
    self.name <=> course.name
  end
end
