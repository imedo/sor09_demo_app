class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :blog_entry_id
      t.string :author
      t.text :text
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
