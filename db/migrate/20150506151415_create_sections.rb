class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.string :call_number
      t.index :call_number
      t.string :status
      t.index :status
      t.integer :open_seats
      t.integer :total_seats
      t.references :course, index: true
      t.references :term, index: true
      t.string :identifier
      t.index :identifier
      t.string :days
      t.datetime :starts_at
      t.datetime :ends_at
      t.timestamps
    end
  end
end
