class AddingMoreIndexes < ActiveRecord::Migration
  def self.up
    add_index :sections, :course_id
    add_index :instructors, :name
  end

  def self.down
    remove_index :sections, :course_id
    remove_index :instructors, :name
  end
end
