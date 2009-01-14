module PagesHelper

  def wikify(str)
    out = str.clone

    # Code Blocks
    # replaces {{{triple braced blocks}}}
    out.gsub!(/(!?)\{\{\{(\r?\n)?(.*?)(\r?\n)?\}\}\}/m) do |match|
      unless $1 == "!"
        r = $3
        p1, p2 = "", ""
        p1, p2 = "<pre class=\"code\">\n", "\n</pre>" if $2 =~ /^[\n\r]/
        p1 + "<code>" + "#{r}" + "</code>" + p2
      else
        match[1, match.length]
      end
    end

    # Wiki links
    # [wiki PageName]
    # [wiki page name in human syntax PageName]
    # [smt else http://link.com]
    out.gsub!(/(!?)\[(.*?)(\|(.*?))?\]/) do |match|
      tokens = $2.split
      if tokens.first == "wiki"
        a = tokens.last
        page_name = a.clone
        page_name.gsub!(/[A-Z]/) { |c| " #{c.downcase}" }.lstrip!

        if tokens.size > 2 # some words override PageName
          a = tokens[1..tokens.size-2].join(" ")
        end

        page = Page.find_by_name(page_name)
        unless page.nil?
          link_to(a, page_url(page))
        else
          link_to(a, new_page_url(:name => page_name),
                  :class => 'nonexistingPage', :title => "Create this page")
        end
      else
        a = tokens.slice(0, tokens.size-1).join(" ")
        link_to(a, tokens.last)
      end
    end

    markdown auto_link out
  end

end
