class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :name, :null => false
      t.string :identifier, :null => false
      t.references :subject, :null => false
      t.timestamps
    end
    add_index(:courses, :identifier)
  end

  def self.down
    drop_table :courses
  end
end
