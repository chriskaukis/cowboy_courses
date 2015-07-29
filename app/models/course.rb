class Course < ActiveRecord::Base  
  belongs_to :subject
  has_many :sections
  has_many :instructors, :through => :sections, :uniq => true
  has_many :terms, :through => :sections, :uniq => true
  has_many :votes, :as => :voteable
  has_many :comments, :as => :commentable
  
  named_scope :top, lambda { |top| { :limit => top, :order => 'hot(courses.ups, courses.downs, courses.comments_count, courses.updated_at) DESC, courses.updated_at DESC' } }
      
  def self.summary(*args)
    sql_joins = <<-SQL
      INNER JOIN (
        SELECT sections.course_id, 
          sections.term_id,
          COUNT(sections.id) AS sections_count,
          SUM(COALESCE(sections.open_seats, 0)) AS open_seats, 
          SUM(COALESCE(total_seats, 0)) AS total_seats 
        FROM sections
        GROUP BY sections.course_id, sections.term_id
      ) sections ON sections.course_id = courses.id       
    SQL
    
    sql_select = <<-SQL
      courses.id, 
      courses.name, 
      courses.identifier, 
      courses.comments_count, 
      courses.ups, 
      courses.downs,
      sections.sections_count, 
      sections.open_seats, 
      sections.total_seats
    SQL
    
    find_options = {
      :order => 'hot(courses.ups, courses.downs, courses.comments_count, courses.updated_at) DESC, courses.updated_at DESC',
      :select => sql_select,
      :joins => sql_joins
    }
    
    # This a total hack for Sphinx full text searching.
    if args.first.is_a?(Array)
      find_options[:conditions] = ['courses.id IN (?)', args.first]
      return all(find_options)
    end
    
    options = args.first
    find_options[:count] = { :select => 'courses.id', :distinct => true }
    find_options[:page] = options[:page]
    find_options[:per_page] = options[:per_page]
    
    conditions = []
    if options.has_key?(:subject) && !options[:subject].nil?
      subject = options[:subject]
      conditions << sanitize_sql_array(['courses.subject_id = ?', subject.id]) if subject.is_a?(Subject)
    end
    
    if options.has_key?(:term) && !options[:term].nil?
      term = options[:term]
      conditions << sanitize_sql_array(['sections.term_id = ?', term.id]) if term.is_a?(Term)
    end
    find_options[:conditions] = conditions.join(' AND ') if conditions.size > 0
    
    paginate(find_options)
  end
  
  def score
    ups - downs
  end

  def <=>(course)
    self.name <=> course.name
  end
  
  def self.count_by_term(term)
    count({
      :conditions => ['term_id = ?', term.id], 
      :joins => [:sections], 
      :distinct => true, 
      :select => 'courses.id'
    })
  end
end
