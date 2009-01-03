class CreateRegistrationCodes < ActiveRecord::Migration
  def self.up
    create_table :registration_codes do |t|
      t.string  :code
      t.boolean :used, :default => false
      t.integer :creator_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :registration_codes
  end
end
