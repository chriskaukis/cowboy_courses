class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, index: true
      t.integer :voteable_id
      t.string :voteable_type
      t.index [:voteable_id, :voteable_type]
      t.integer :points
      t.index :points
      t.timestamps
    end
  end
end