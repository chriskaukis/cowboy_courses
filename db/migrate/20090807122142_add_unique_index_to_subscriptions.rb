class AddUniqueIndexToSubscriptions < ActiveRecord::Migration
  def self.up
    add_index(:subscriptions, [:user_id, :section_id], :unique => true)
  end

  def self.down
    remove_index(:subscriptions, [:user_id, :section_id])
  end
end
