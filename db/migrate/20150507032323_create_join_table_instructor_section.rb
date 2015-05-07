class CreateJoinTableInstructorSection < ActiveRecord::Migration
  def change
    create_join_table :instructors, :sections do |t|
      t.index [:instructor_id, :section_id]
      t.index [:section_id, :instructor_id]
    end
  end
end
