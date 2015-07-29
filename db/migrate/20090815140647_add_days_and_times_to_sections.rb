class AddDaysAndTimesToSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :starts_at, :time
    add_column :sections, :ends_at, :time
    add_column :sections, :days, :string, :limit => 10
  end

  def self.down
    remove_column :sections, :starts_at
    remove_column :sections, :ends_at
    remove_column :sections, :days
  end
end
