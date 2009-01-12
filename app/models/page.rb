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
    rev_date = self.revisions.last.created_at
    self_date = self.updated_at
    return (rev_date > self_date) ? rev_date : self_date
  end

end
