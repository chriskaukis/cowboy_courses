class AddNotesToSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :notes, :text
  end

  def self.down
    remove_column :sections, :notes
  end
end
