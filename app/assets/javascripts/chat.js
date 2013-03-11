$(function () {
    setInterval((function () {
        $('#new_chat').load('/users/chatroom #chat_room');
    }), 9000);
});
