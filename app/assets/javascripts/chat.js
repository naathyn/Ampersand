$(function () {
    setInterval((function () {
        $('#new_chat').load('/users/chatroom #chat_room');
    }), 9000);

    setInterval((function () {
        $('#chatting').load('/users/chatroom #chat_icons');
    }), 60000);
});
