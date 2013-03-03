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

  def note_for_comment
    [ "Tell me something good",
      "Let me know what you think",
      "Leave a comment!",
      "Tell me something good",
      "What are your thoughts?",
      "What is your take on this?",
      "Did you like it?",
      "Let me know what you think",
      "Shoot me a comment!",
      "Now it's your turn to write something",
      "Opinions?",
      "Can I get an amen?",
      "I'd love to hear what you think",
      "Comments?"
    ].shuffle.last
  end
end
