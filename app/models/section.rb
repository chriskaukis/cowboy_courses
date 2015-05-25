class Section < ActiveRecord::Base
	has_and_belongs_to_many :instructors
	belongs_to :course
	belongs_to :term
end
