class Subject < ActiveRecord::Base
  default_scope :order => 'name'
  
  named_scope :by_instructor, lambda { |instructor| { :conditions => ['instructors.id = ?', instructor.id], :select => 'DISTINCT subjects.*', :joins => 'INNER JOIN courses ON courses.subject_id = subjects.id INNER JOIN sections ON sections.course_id = courses.id INNER JOIN instructors ON instructors.id = sections.instructor_id' } }
  
  has_many :courses
  has_many :sections, :through => :courses
  
  def self.summary_by_term(term)
    sql = <<-SQL
      SELECT subjects.id, subjects.identifier, subjects.name, COUNT(DISTINCT courses.id) AS courses_count
      FROM subjects
      INNER JOIN courses ON courses.subject_id = subjects.id
      INNER JOIN sections ON sections.course_id = courses.id
      WHERE sections.term_id = ?
      GROUP BY subjects.id, subjects.identifier, subjects.name
      ORDER BY subjects.name    
    SQL
    find_by_sql([sql, term.id])
  end
  
  def self.count_by_term(term)
    count({
      :conditions => ['term_id = ?', term.id], 
      :joins => [{ :courses => :sections }], 
      :distinct => true, 
      :select => 'subjects.id'
    })
  end
  
  def <=>(subject)
    self.name <=> subject.name
  end
end
