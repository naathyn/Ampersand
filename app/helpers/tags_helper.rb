module TagsHelper
  def icon_for(tag)
    icon = tag.tagging_count > 1 ? '<i class="icon-tags"></i>' : '<i class="icon-tag"></i>'
    icon.html_safe
  end
end
