module TagsHelper
  def icon_for(tag)
    if tag.tagging_count > 1
      icon = "<i class=\"icon-tags\"></i>"
    else
      icon = "<i class=\"icon-tag\"></i>"
    end
    icon.html_safe
  end
end
