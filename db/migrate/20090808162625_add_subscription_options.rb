class AddSubscriptionOptions < ActiveRecord::Migration
  def self.up
    add_column :subscriptions, :status_notification, :boolean, :default => false
    add_column :subscriptions, :instructor_notification, :boolean, :default => false
    add_column :users, :status_notification, :boolean, :default => false
    add_column :users, :instructor_notification, :boolean, :default => false
  end

  def self.down
    remove_column :subscriptions, :status_notification
    remove_column :subscriptions, :instructor_notification
    remove_column :users, :status_notification
    remove_column :users, :instructor_notification
  end
end
