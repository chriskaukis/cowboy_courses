class AddNotificationOptions < ActiveRecord::Migration
  def self.up
    add_column :users, :email_notification, :boolean, :default => false
    add_column :users, :sms_notification, :boolean, :default => false
  end

  def self.down
    remove_column :users, :email_notification
    remove_column :users, :sms_notification
  end
end
