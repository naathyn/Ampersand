module ApplicationHelper

  def full_title(page_title)
    base_title = "&mpersand"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def viewing_blog?
    "blogging" if
      controller_name == "blogs"    ||
      action_name     == "blog"     ||
      controller_name == "tags"     ||
      controller_name == "comments"
  end

  def micropost_synonyms
    [ "Thoughts",
      "Ideas",
      "Shoutouts",
      "Opinions",
      "Shares",
      "Posts",
      "Expressions",
      "Memories",
      "Concepts"
    ].shuffle.last
  end
end
