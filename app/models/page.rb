class Page < ActiveRecord::Base

  has_many :revisions, :dependent => :destroy
  belongs_to :user

  validates_presence_of :name

end
