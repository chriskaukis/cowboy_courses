class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :name
      t.string :identifier
      t.index :identifier
      t.timestamps
    end
  end
end
