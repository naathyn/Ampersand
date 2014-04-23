module ApplicationHelper
  include Greeter
  include MailboxHelper

  def full_title(page_title)
    base_title = "&mpersand"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}".html_safe
    end
  end
end
