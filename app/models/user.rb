
require 'digest/sha1'

class User < ActiveRecord::Base

  has_many :identity_urls, :dependent => :destroy

  before_save :generate_salt

  # Encrypts some data with the salt.
  def self.encrypt(something, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{something}--")
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  protected

  def generate_salt
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{nickname}--") if new_record?
  end

end
