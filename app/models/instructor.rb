class Instructor < ActiveRecord::Base
  has_many :sections
  has_many :courses, :through => :sections, :uniq => true
  has_many :votes, :as => :voteable
  has_many :comments, :as => :commentable

  named_scope :top, lambda { |top| { :limit => top, :order => 'hot(instructors.ups, instructors.downs, instructors.comments_count, instructors.updated_at) DESC, instructors.updated_at DESC' } }
  named_scope :by_term_and_course, lambda { |term, course| { :joins => { :sections => [:term, :course] }, :conditions => ["courses.id = ? AND terms.id = ? AND terms.disabled = ?", course.id, term.id, false], :select => 'DISTINCT instructors.*' } }  
      
  # TODO: Refactor me, somebody!? Please?!?!
  def self.summary(options = {})
    paginate_options = {
      :page => options[:page],
      :per_page => options[:per_page],
      :count => { :select => 'instructors.id' }
    }
    
    paginate_options[:select] = <<-SQL
      instructors.id,
      instructors.ups,
      instructors.downs,
      instructors.comments_count,
      instructors.name,
      sections.sections_count
    SQL
    
    if options.has_key?(:term) && options[:term].is_a?(Term)
      term = options[:term]
      paginate_options[:joins] = sanitize_sql_array(['INNER JOIN (SELECT s.instructor_id, COUNT(s.id) AS sections_count FROM sections s WHERE s.term_id = ? GROUP BY s.instructor_id) sections ON sections.instructor_id = instructors.id', term.id])
    else
      paginate_options[:joins] = 'INNER JOIN (SELECT s.instructor_id, COUNT(s.id) AS sections_count FROM sections s GROUP BY s.instructor_id) sections ON sections.instructor_id = instructors.id'
    end
    paginate_options[:order] ||= 'hot(instructors.ups, instructors.downs, instructors.comments_count, instructors.updated_at) DESC, instructors.updated_at DESC'
    paginate(paginate_options)
  end
  
  def like!(user)
    votes.create(:user => user, :points => 1)
  end

  def dislike!(user)
    votes.create(:user => user, :points => -1)
  end
  
  def score
    ups - downs
  end
  
  def <=>(instructor)
    self.name <=> instructor.name
  end
  
  def self.count_by_term(term)
    count({
      :conditions => ['term_id = ?', term.id], 
      :joins => [:sections], 
      :select => 'instructors.id', 
      :distinct => true
    })
  end
end
