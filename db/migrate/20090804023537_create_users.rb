class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :identity_url
      t.timestamps
    end
    add_index :users, :identity_url
    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
