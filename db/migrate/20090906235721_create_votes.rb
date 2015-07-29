class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :user_id
      t.integer :voteable_id
      t.string :voteable_type
      t.integer :points
      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, [:voteable_id, :voteable_type]
    add_index :votes, :points
  end

  def self.down
    drop_table :votes
  end
end
