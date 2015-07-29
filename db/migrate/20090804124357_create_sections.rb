class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :name
      t.string :call_number, :null => false
      t.string :status, :null => false, :default => 'unknown'
      t.integer :open_seats
      t.integer :total_seats
      t.references :instructor
      t.references :term, :null => false
      t.references :course, :null => false
      t.string :identifier, :null => false
      t.timestamps
    end
    add_index(:sections, :call_number)
    add_index(:sections, :identifier)
  end

  def self.down
    drop_table :sections
  end
end
