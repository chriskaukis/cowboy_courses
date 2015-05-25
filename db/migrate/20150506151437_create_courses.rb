class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :identifier
      t.index :identifier
      t.references :subject, index: true
      t.timestamps
    end
  end
end
