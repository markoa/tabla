class CreateRevisions < ActiveRecord::Migration
  def self.up
    create_table :revisions do |t|
      t.text :content
      t.string :comment
      t.boolean :minor, :default => false
      t.references :page
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :revisions
  end
end
