class RemoveSaltFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :salt
  end

  def self.down
    add_column :users, :salt, :string, :limit => 40
  end
end
