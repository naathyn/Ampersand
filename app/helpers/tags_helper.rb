module TagsHelper
  def icon_for(tag)
    icon = tag.tagging_count > 1 ? '<i class="icon-tags"></i>' : '<i class="icon-tag"></i>'
    icon.html_safe
  end

  def badge_for(tag)
    tagging_count = tag.tagging_count
    if action_name == "blog"
      user_tag_count = @user.tags.where(name: tag.name).count
      tagging_count = user_tag_count
    end
    if tagging_count >= 10
      badge = "<span class=\"badge badge-important\">#{tagging_count}</span>"
    elsif tagging_count >= 6
      badge = "<span class=\"badge badge-success\">#{tagging_count}</span>"
    else
      badge = "<span class=\"badge badge-info\">#{tagging_count}</span>"
    end
    badge.html_safe
  end
end
