jQuery ->

  setInterval (->
    $("#new_chat").load "/users/chatroom #chat_room" 

  ), 9000
