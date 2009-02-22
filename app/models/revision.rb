class Revision < ActiveRecord::Base

  belongs_to :page
  belongs_to :user

  validates_presence_of :content

  # Returns the revision number as a human-readable number
  # between 1 and parent's total revision count
  def hid
    i = page.revisions.length - 1
    until i == 0 || page.revisions[i] == self
      i -= 1
    end
    i+1
  end

  def first?
    page.revisions.first == self
  end

end
