class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :terms, :name
    add_index :sections, :term_id
    add_index :sections, :instructor_id
    add_index :sections, :name
    add_index :courses, :subject_id
    add_index :courses, :name
    add_index :subjects, :name
  end

  def self.down
    add_index :terms, :name
    add_index :sections, :term_id
    add_index :sections, :instructor_id
    add_index :sections, :name
    add_index :courses, :subject_id
    add_index :courses, :name
    add_index :subjects, :name
  end
end
