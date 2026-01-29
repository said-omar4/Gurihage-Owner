// lib/features/chats/presentation/screens/chat_conversation.dart
import 'package:flutter/material.dart';
import 'package:xirfadsan_receipt/features/chats/presentation/screens/chat_item.dart';

class ChatConversation extends StatefulWidget {
  final ChatItem chat;

  const ChatConversation({super.key, required this.chat});

  @override
  State<ChatConversation> createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatConversation> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Add sample messages
    _messages.addAll([
      {
        'text': 'Hello! How are you doing today?',
        'isMe': false,
        'time': '4:25 PM',
      },
      {
        'text': 'I\'m doing great! Just finished the property inspection.',
        'isMe': true,
        'time': '4:26 PM',
      },
      {
        'text': 'That\'s awesome! When can I move in?',
        'isMe': false,
        'time': '4:28 PM',
      },
      {
        'text': 'You can move in next Monday. I\'ll send you the contract.',
        'isMe': true,
        'time': '4:29 PM',
      },
    ]);
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'text': text,
        'isMe': true,
        'time': _getCurrentTime(),
      });
      _messageController.clear();
      _isTyping = false;
    });

    // Simulate reply after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'text': 'Got it! Thanks for the update.',
          'isMe': false,
          'time': _getCurrentTime(),
        });
      });
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour % 12;
    final minute = now.minute;
    final period = now.hour < 12 ? 'AM' : 'PM';
    return '${hour == 0 ? 12 : hour}:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    // ✅ INDIVIDUAL CHAT ONLY - NO EDIT BUTTON
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            // Avatar
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  widget.chat.name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.chat.isOnline ? 'Online' : 'Offline',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Phone call button
          IconButton(
            icon: const Icon(Icons.phone, size: 22),
            color: const Color(0xFF22C55E),
            onPressed: () {
              // Handle phone call
            },
          ),
          // Video call button
          IconButton(
            icon: const Icon(Icons.videocam, size: 22),
            color: const Color(0xFF22C55E),
            onPressed: () {
              // Handle video call
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: false,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Typing Indicator
          if (widget.chat.isTyping) _buildTypingIndicator(),

          // Input Bar
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isMe = message['isMe'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  widget.chat.name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          if (!isMe) const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? const Color(0xFF22C55E) : Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: isMe
                          ? const Radius.circular(16)
                          : const Radius.circular(4),
                      bottomRight: isMe
                          ? const Radius.circular(4)
                          : const Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    message['text'],
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message['time'],
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  widget.chat.name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          // Image Button
          IconButton(
            icon: const Icon(Icons.image, color: Colors.grey),
            onPressed: () {
              // Handle image upload
            },
          ),

          // Message Input
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFA),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        setState(() {
                          _isTyping = text.isNotEmpty;
                        });
                      },
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined,
                        color: Colors.grey),
                    onPressed: () {
                      // Open emoji picker
                    },
                  ),
                ],
              ),
            ),
          ),

          // Send Button
          const SizedBox(width: 8),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E),
              borderRadius: BorderRadius.circular(22),
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

// // lib/features/chats/presentation/screens/chat_conversation.dart
// import 'package:flutter/material.dart';
// import 'package:xirfadsan_receipt/features/chats/presentation/screens/EditGroupChat.dart';
// import 'package:xirfadsan_receipt/features/chats/presentation/screens/chat_item.dart';
// import 'package:iconsax/iconsax.dart'; // Add this import

// class ChatConversation extends StatefulWidget {
//   final ChatItem chat;

//   const ChatConversation({super.key, required this.chat});

//   @override
//   State<ChatConversation> createState() => _ChatConversationState();
// }

// class _ChatConversationState extends State<ChatConversation> {
//   final TextEditingController _messageController = TextEditingController();
//   final List<Map<String, dynamic>> _messages = [];
//   bool _isTyping = false;

//   @override
//   void initState() {
//     super.initState();
//     // Add sample messages
//     _messages.addAll([
//       {
//         'text': 'Hello! How are you doing today?',
//         'isMe': false,
//         'time': '4:25 PM',
//       },
//       {
//         'text': 'I\'m doing great! Just finished the property inspection.',
//         'isMe': true,
//         'time': '4:26 PM',
//       },
//       {
//         'text': 'That\'s awesome! When can I move in?',
//         'isMe': false,
//         'time': '4:28 PM',
//       },
//       {
//         'text': 'You can move in next Monday. I\'ll send you the contract.',
//         'isMe': true,
//         'time': '4:29 PM',
//       },
//     ]);
//   }

//   void _sendMessage() {
//     final text = _messageController.text.trim();
//     if (text.isEmpty) return;

//     setState(() {
//       _messages.add({
//         'text': text,
//         'isMe': true,
//         'time': _getCurrentTime(),
//       });
//       _messageController.clear();
//       _isTyping = false;
//     });

//     // Simulate reply after 1 second
//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _messages.add({
//           'text': 'Got it! Thanks for the update.',
//           'isMe': false,
//           'time': _getCurrentTime(),
//         });
//       });
//     });
//   }

//   String _getCurrentTime() {
//     final now = DateTime.now();
//     final hour = now.hour % 12;
//     final minute = now.minute;
//     final period = now.hour < 12 ? 'AM' : 'PM';
//     return '${hour == 0 ? 12 : hour}:${minute.toString().padLeft(2, '0')} $period';
//   }

//   void _navigateToEditGroup() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => EditGroupChatScreen(groupId: widget.chat.id),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Row(
//           children: [
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF22C55E),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: widget.chat.isGroup
//                     ? const Icon(Icons.people, color: Colors.white, size: 20)
//                     : Text(
//                         widget.chat.name[0],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.chat.name,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   widget.chat.isOnline ? 'Online' : 'Offline',
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           // ✅ EDIT GROUP BUTTON (Only for groups)
//           if (widget.chat.isGroup)
//             IconButton(
//               icon: const Icon(Iconsax.edit_2, size: 22),
//               color: const Color(0xFF22C55E),
//               onPressed: _navigateToEditGroup,
//             ),
//           IconButton(
//             icon: const Icon(Icons.phone, size: 22),
//             color: const Color(0xFF22C55E),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.videocam, size: 22),
//             color: const Color(0xFF22C55E),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Messages
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               reverse: false,
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return _buildMessageBubble(message);
//               },
//             ),
//           ),

//           // Typing Indicator
//           if (widget.chat.isTyping) _buildTypingIndicator(),

//           // Input Bar
//           _buildInputBar(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageBubble(Map<String, dynamic> message) {
//     final isMe = message['isMe'] as bool;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         mainAxisAlignment:
//             isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           if (!isMe)
//             Container(
//               width: 32,
//               height: 32,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF22C55E),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Center(
//                 child: widget.chat.isGroup
//                     ? const Icon(Icons.people, color: Colors.white, size: 16)
//                     : Text(
//                         widget.chat.name[0],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//               ),
//             ),
//           if (!isMe) const SizedBox(width: 8),
//           Flexible(
//             child: Column(
//               crossAxisAlignment:
//                   isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: isMe ? const Color(0xFF22C55E) : Colors.grey[100],
//                     borderRadius: BorderRadius.only(
//                       topLeft: const Radius.circular(16),
//                       topRight: const Radius.circular(16),
//                       bottomLeft: isMe
//                           ? const Radius.circular(16)
//                           : const Radius.circular(4),
//                       bottomRight: isMe
//                           ? const Radius.circular(4)
//                           : const Radius.circular(16),
//                     ),
//                   ),
//                   child: Text(
//                     message['text'],
//                     style: TextStyle(
//                       color: isMe ? Colors.white : Colors.black,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   message['time'],
//                   style: const TextStyle(
//                     fontSize: 10,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTypingIndicator() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 32,
//             height: 32,
//             decoration: BoxDecoration(
//               color: const Color(0xFF22C55E),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(
//               child: widget.chat.isGroup
//                   ? const Icon(Icons.people, color: Colors.white, size: 16)
//                   : Text(
//                       widget.chat.name[0],
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 8,
//                   height: 8,
//                   margin: const EdgeInsets.only(right: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[600],
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 Container(
//                   width: 8,
//                   height: 8,
//                   margin: const EdgeInsets.only(right: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[600],
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 Container(
//                   width: 8,
//                   height: 8,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[600],
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInputBar() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       color: Colors.white,
//       child: Row(
//         children: [
//           // Image Button
//           IconButton(
//             icon: const Icon(Icons.image, color: Colors.grey),
//             onPressed: () {},
//           ),

//           // Message Input
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFAFAFA),
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: Row(
//                 children: [
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(
//                         hintText: 'Type a message...',
//                         border: InputBorder.none,
//                       ),
//                       onChanged: (text) {
//                         setState(() {
//                           _isTyping = text.isNotEmpty;
//                         });
//                       },
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.emoji_emotions_outlined,
//                         color: Colors.grey),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Send Button
//           const SizedBox(width: 8),
//           Container(
//             width: 44,
//             height: 44,
//             decoration: BoxDecoration(
//               color: const Color(0xFF22C55E),
//               borderRadius: BorderRadius.circular(22),
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.send, color: Colors.white, size: 20),
//               onPressed: _sendMessage,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // lib/features/chats/presentation/screens/chat_conversation.dart
// import 'package:flutter/material.dart';
// import 'package:xirfadsan_receipt/features/chats/presentation/screens/chat_item.dart';

// class ChatConversation extends StatefulWidget {
//   final ChatItem chat;

//   const ChatConversation({super.key, required this.chat});

//   @override
//   State<ChatConversation> createState() => _ChatConversationState();
// }

// class _ChatConversationState extends State<ChatConversation> {
//   final TextEditingController _messageController = TextEditingController();
//   final List<Map<String, dynamic>> _messages = [];
//   bool _isTyping = false;

//   @override
//   void initState() {
//     super.initState();
//     // Add sample messages
//     _messages.addAll([
//       {
//         'text': 'Hello! How are you doing today?',
//         'isMe': false,
//         'time': '4:25 PM',
//       },
//       {
//         'text': 'I\'m doing great! Just finished the property inspection.',
//         'isMe': true,
//         'time': '4:26 PM',
//       },
//       {
//         'text': 'That\'s awesome! When can I move in?',
//         'isMe': false,
//         'time': '4:28 PM',
//       },
//       {
//         'text': 'You can move in next Monday. I\'ll send you the contract.',
//         'isMe': true,
//         'time': '4:29 PM',
//       },
//     ]);
//   }

//   void _sendMessage() {
//     final text = _messageController.text.trim();
//     if (text.isEmpty) return;

//     setState(() {
//       _messages.add({
//         'text': text,
//         'isMe': true,
//         'time': _getCurrentTime(),
//       });
//       _messageController.clear();
//       _isTyping = false;
//     });

//     // Simulate reply after 1 second
//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _messages.add({
//           'text': 'Got it! Thanks for the update.',
//           'isMe': false,
//           'time': _getCurrentTime(),
//         });
//       });
//     });
//   }

//   String _getCurrentTime() {
//     final now = DateTime.now();
//     final hour = now.hour % 12;
//     final minute = now.minute;
//     final period = now.hour < 12 ? 'AM' : 'PM';
//     return '${hour == 0 ? 12 : hour}:${minute.toString().padLeft(2, '0')} $period';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Row(
//           children: [
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF22C55E),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: widget.chat.isGroup
//                     ? const Icon(Icons.people, color: Colors.white, size: 20)
//                     : Text(
//                         widget.chat.name[0],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.chat.name,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   widget.chat.isOnline ? 'Online' : 'Offline',
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.phone),
//             color: const Color(0xFF22C55E),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.videocam),
//             color: const Color(0xFF22C55E),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Messages
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               reverse: false,
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return _buildMessageBubble(message);
//               },
//             ),
//           ),

//           // Typing Indicator
//           if (widget.chat.isTyping) _buildTypingIndicator(),

//           // Input Bar
//           _buildInputBar(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageBubble(Map<String, dynamic> message) {
//     final isMe = message['isMe'] as bool;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         mainAxisAlignment:
//             isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         children: [
//           if (!isMe)
//             Container(
//               width: 32,
//               height: 32,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF22C55E),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Center(
//                 child: widget.chat.isGroup
//                     ? const Icon(Icons.people, color: Colors.white, size: 16)
//                     : Text(
//                         widget.chat.name[0],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//               ),
//             ),
//           if (!isMe) const SizedBox(width: 8),
//           Flexible(
//             child: Column(
//               crossAxisAlignment:
//                   isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: isMe ? const Color(0xFF22C55E) : Colors.grey[100],
//                     borderRadius: BorderRadius.only(
//                       topLeft: const Radius.circular(16),
//                       topRight: const Radius.circular(16),
//                       bottomLeft: isMe
//                           ? const Radius.circular(16)
//                           : const Radius.circular(4),
//                       bottomRight: isMe
//                           ? const Radius.circular(4)
//                           : const Radius.circular(16),
//                     ),
//                   ),
//                   child: Text(
//                     message['text'],
//                     style: TextStyle(
//                       color: isMe ? Colors.white : Colors.black,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   message['time'],
//                   style: const TextStyle(
//                     fontSize: 10,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTypingIndicator() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 32,
//             height: 32,
//             decoration: BoxDecoration(
//               color: const Color(0xFF22C55E),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(
//               child: widget.chat.isGroup
//                   ? const Icon(Icons.people, color: Colors.white, size: 16)
//                   : Text(
//                       widget.chat.name[0],
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 8,
//                   height: 8,
//                   margin: const EdgeInsets.only(right: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[600],
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 Container(
//                   width: 8,
//                   height: 8,
//                   margin: const EdgeInsets.only(right: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[600],
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 Container(
//                   width: 8,
//                   height: 8,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[600],
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInputBar() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       color: Colors.white,
//       child: Row(
//         children: [
//           // Image Button
//           IconButton(
//             icon: const Icon(Icons.image, color: Colors.grey),
//             onPressed: () {},
//           ),

//           // Message Input
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFAFAFA),
//                 borderRadius: BorderRadius.circular(24),
//               ),
//               child: Row(
//                 children: [
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(
//                         hintText: 'Type a message...',
//                         border: InputBorder.none,
//                       ),
//                       onChanged: (text) {
//                         setState(() {
//                           _isTyping = text.isNotEmpty;
//                         });
//                       },
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.emoji_emotions_outlined,
//                         color: Colors.grey),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Send Button
//           const SizedBox(width: 8),
//           Container(
//             width: 44,
//             height: 44,
//             decoration: BoxDecoration(
//               color: const Color(0xFF22C55E),
//               borderRadius: BorderRadius.circular(22),
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.send, color: Colors.white, size: 20),
//               onPressed: _sendMessage,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
