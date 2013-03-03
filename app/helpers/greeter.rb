module Greeter
  def say_hello
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
  def say_goodbye
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
