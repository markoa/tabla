
require 'digest/sha1'

class RegistrationCode < ActiveRecord::Base

  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  belongs_to :user

  def self.generate(user)
    return nil if user.nil? or not user.kind_of? User
    create(:code => Digest::SHA1.hexdigest(Time.now.utc.to_s),
           :creator_id => user.id)
  end

  def assign_to(user)
    self.user = user
    save
  end

  protected

  def before_save
    self.used = true if not user_id.nil?
  end

end
