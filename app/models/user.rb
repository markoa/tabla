
class User < ActiveRecord::Base

  has_many :identity_urls, :dependent => :destroy

  has_many :created_registration_codes,
           :class_name => 'RegistrationCode',
           :foreign_key => 'creator_id'

  has_one  :registration_code

  has_many :pages
  has_many :revisions

  validates_presence_of :nickname, :email
  validates_uniqueness_of :nickname, :email

end
