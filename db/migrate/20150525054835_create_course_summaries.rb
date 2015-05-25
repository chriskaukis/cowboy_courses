class CreateCourseSummaries < ActiveRecord::Migration
  def up
    execute <<-SQL
create or replace view course_summaries as
select
  courses.id, 
  courses.name, 
  courses.identifier, 
  courses.comments_count, 
  courses.ups, 
  courses.downs,
  j1.term_id,
  j1.sections_count, 
  j1.open_seats, 
  j1.total_seats
from courses
  INNER JOIN (
    SELECT sections.course_id, 
      sections.term_id,
      COUNT(sections.id) AS sections_count,
      SUM(COALESCE(sections.open_seats, 0)) AS open_seats, 
      SUM(COALESCE(total_seats, 0)) AS total_seats 
    FROM sections
    GROUP BY sections.course_id, sections.term_id
  ) j1 ON j1.course_id = courses.id
    SQL
  end

  def down
    execute <<-SQL
drop view course_summaries
    SQL
  end
end
