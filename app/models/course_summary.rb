class CourseSummary < ActiveRecord::Base
  belongs_to :term
  has_many :sections
end
