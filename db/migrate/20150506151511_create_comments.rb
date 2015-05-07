class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.string :commentable_type
      t.integer :commentable_id
      t.index [:commentable_type, :commentable_id]
      t.text :content
      t.timestamps
    end
  end
end