module PagesHelper

  def wikify(str)
    out = auto_link str

    # Wiki links
    # [wiki PageName]
    out.gsub!(/(!?)\[(.*?)(\|(.*?))?\]/) do |match|
      name = $2.split.last
      typed_name = name.clone
      name.gsub!(/[A-Z]/) { |c| " #{c.downcase}" }.lstrip!
      logger.info name
      page = Page.find_by_name(name)
      link_to typed_name, page_url(page)
    end

    markdown out
  end

end
