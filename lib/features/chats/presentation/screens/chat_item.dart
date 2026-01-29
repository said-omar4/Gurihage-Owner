// lib/models/chat_item.dart
class ChatItem {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final bool isTyping;
  final bool isGroup;

  const ChatItem({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
    this.isTyping = false,
    this.isGroup = false,
  });
}
