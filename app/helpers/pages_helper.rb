module PagesHelper

  def wikify(str)
    out = str.clone

    # Wiki links
    # [wiki PageName]
    # [smt else http://link.com]
    out.gsub!(/(!?)\[(.*?)(\|(.*?))?\]/) do |match|
      tokens = $2.split
      if tokens.size == 2 and tokens.first == "wiki"
        a = tokens.last
        page_name = a.clone
        page_name.gsub!(/[A-Z]/) { |c| " #{c.downcase}" }.lstrip!

        page = Page.find_by_name(page_name)
        unless page.nil?
          link_to(a, page_url(page))
        else
          link_to(a, new_page_url, :title => "Create this page")
        end
      else
        a = tokens.slice(0, tokens.size-1).join(" ")
        link_to(a, tokens.last)
      end
    end

    markdown auto_link out
  end

end
