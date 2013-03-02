module Greeter
  def say_hello
    [ "Welcome back",
      "Welkom terug",
      "Maligayang pagbalik",
      "Bienvenue à nouveau",
      "Willkommen zurück",
      "Üdvözöljük",
      "Bentornato",
      "Velkommen tilbake",
      "Bem-vindo de volta",
      "Bine ai revenit",
      "Bienvenido de nuevo",
      "Chào mừng trở lại"
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
      "Búcsú!",
      "Addio!",
      "Pożegnanie!",
      "¡hasta la vista",
      "Tạm Biệt",
      "Farvel!"
    ].shuffle.last
  end
end
