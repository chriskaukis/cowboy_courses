class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :identifier
      t.index :identifier
      t.timestamps
    end
  end
end
