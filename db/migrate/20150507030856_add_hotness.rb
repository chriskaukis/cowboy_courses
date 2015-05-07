class AddHotness < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        add_column :courses, :ups, :integer, :default => 0, :null => false
        add_column :courses, :downs, :integer, :default => 0, :null => false
        add_column :courses, :comments_count, :integer, :null => false, :default => 0
        add_column :instructors, :ups, :integer, :default => 0, :null => false
        add_column :instructors, :downs, :integer, :default => 0, :null => false
        add_column :instructors, :comments_count, :integer, :null => false, :default => 0

        # our hot algorithm, this will need tweaking.
        sql = <<-SQL
          create or replace function hot(ups integer, downs integer, comments_count integer, updated_at timestamp without time zone) returns numeric as $$
            select round(cast(date_part('epoch', $4) * 4.0 * (abs($1 - $2) + $3) as numeric), 7)
          $$ language sql immutable;
          create index index_hot_on_courses ON courses (hot(ups, downs, comments_count, updated_at), updated_at);
          create index index_hot_on_instructors ON instructors (hot(ups, downs, comments_count, updated_at), updated_at);

          UPDATE instructors SET comments_count = (
              SELECT COUNT(*) FROM comments WHERE commentable_type = 'Instructor' AND commentable_id = instructors.id
            );

          UPDATE instructors SET ups = (
            SELECT COALESCE(SUM(points), 0) FROM votes WHERE voteable_type = 'Instructor' AND voteable_id = instructors.id AND points > 0
          ), downs = (
            SELECT COALESCE(SUM(ABS(points)), 0) FROM votes WHERE voteable_type = 'Instructor' AND voteable_id = instructors.id AND points < 0
          );

          UPDATE courses SET comments_count = (
              SELECT COUNT(*) FROM comments WHERE commentable_type = 'Course' AND commentable_id = courses.id
            );

          UPDATE courses SET ups = (
            SELECT COALESCE(SUM(points), 0) FROM votes WHERE voteable_type = 'Course' AND voteable_id = courses.id AND points > 0
          ), downs = (
            SELECT COALESCE(SUM(ABS(points)), 0) FROM votes WHERE voteable_type = 'Course' AND voteable_id = courses.id AND points < 0
          );
        SQL
        ActiveRecord::Base.connection.execute(sql)
      end

      dir.down do
        remove_column :courses, :comments_count
        remove_column :courses, :downs
        remove_column :courses, :ups
        remove_column :instructors, :comments_count
        remove_column :instructors, :downs
        remove_column :instructors, :ups

        sql = <<-SQL
          drop index index_hot_on_courses;
          drop index index_hot_on_instructors;
          drop function hot(ups integer, downs integer, comments_count integer, updated_at timestamp without time zone);
        SQL
        ActiveRecord::Base.connection.execute(sql)
      end
    end
  end
end