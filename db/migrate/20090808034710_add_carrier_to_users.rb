class AddCarrierToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :carrier, :string, :limit => 20
  end

  def self.down
    remove_column :users, :carrier
  end
end