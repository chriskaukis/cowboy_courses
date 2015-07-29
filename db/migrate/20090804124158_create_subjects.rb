class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string :name, :null => false
      t.string :identifier, :null => false
      t.timestamps
    end
    add_index(:subjects, :identifier)
  end

  def self.down
    drop_table :subjects
  end
end
