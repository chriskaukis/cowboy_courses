class CreateTerms < ActiveRecord::Migration
  def self.up
    create_table :terms do |t|
      t.string :name, :null => false
      t.string :identifier, :null => false
      t.boolean :disabled, :null => false, :default => false
      t.timestamps
    end
    add_index :terms, :identifier
  end

  def self.down
    drop_table :terms
  end
end
