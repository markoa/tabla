class AddSaltToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :salt, :string, :limit => 40
  end

  def self.down
    remove_column :users, :salt
  end
end
