# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Takes a number and returns a string like "23rd"
  def suffixed_number(num)
    last_digit = num.to_s.last
    case last_digit
    when "1"
      suffix = "st"
    when "2"
      suffix = "nd"
    when "3"
      suffix = "rd"
    else
      suffix = "th"
    end
    "#{num}#{suffix}"
  end

end
