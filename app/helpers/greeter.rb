module Greeter

  def viewing_blog?
    "blogging" if
      controller_name == "blogs"  ||
      action_name     == "blog"   ||
      controller_name == "tags"   ||
      controller_name == "comments"
  end

  def micropost_synonyms
    [ "Thoughts",
      "Shoutouts",
      "Shares",
      "Posts",
      "Expressions",
      "Memories",
      "Concepts"
    ].shuffle.first
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
    ].shuffle.first
  end

private

  def self.say_hello
    [ "Welcome back",
      "Welkom terug",
      "Maligayang pagbalik",
      "Bienvenue a nouveau",
      "Willkommen zuruck",
      "Bentornato",
      "Velkommen tilbake",
      "Bem-vindo de volta",
      "Bine ai revenit",
      "Bienvenido de nuevo"
    ].shuffle.last
  end

  def self.say_goodbye
    [ "Goodbye!",
      "La Revedere!",
      "Paalam!",
      "Au Revoir!",
      "Adeus!",
      "Ceau!",
      "Auf Wiedersehen!",
      "Addio!",
      "Hasta la vista!",
      "Farvel!"
    ].shuffle.last
  end
end
