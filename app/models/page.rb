class Page < ActiveRecord::Base

  has_many :revisions, :dependent => :destroy
  belongs_to :user

  validates_presence_of :name
  validates_uniqueness_of :name

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end

  def content
    self.revisions.last.content
  end

  def last_updated_at
    self.revisions.last.created_at
  end

  def last_updater
    self.revisions.last.user
  end

end
