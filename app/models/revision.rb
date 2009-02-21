class Revision < ActiveRecord::Base

  belongs_to :page
  belongs_to :user

  validates_presence_of :content

  # Returns the revision number as a human-readable number
  # between 1 and parent's total revision count
  def hid
    return 1 if page.revisions.nil?

    n = 0
    until n >= page.revisions.length || page.revisions[n] == self
      n += 1
    end
    page.revisions.length - n
  end

end
