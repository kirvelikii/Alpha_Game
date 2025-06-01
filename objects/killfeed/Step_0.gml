// Удаляем старые сообщения
for (var i = array_length(messages) - 1; i >= 0; i--) {
    messages[i].timer--;
    if (messages[i].timer <= 0) {
        array_delete(messages, i, 1);
    }
}
for (var i = array_length(feed) - 1; i >= 0; i--) {
    feed[i].timer--;
    if (feed[i].timer <= 0) {
        array_delete(feed, i, 1);
    }
}