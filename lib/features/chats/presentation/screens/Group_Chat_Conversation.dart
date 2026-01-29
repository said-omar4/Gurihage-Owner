// lib/features/chats/presentation/screens/group_chat_conversation_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/features/chats/presentation/screens/EditGroupChat.dart';
import 'package:xirfadsan_receipt/features/chats/presentation/screens/group_info.dart';

class GroupChatConversationScreen extends StatefulWidget {
  final String groupId;
  final String groupName;

  const GroupChatConversationScreen({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  @override
  State<GroupChatConversationScreen> createState() =>
      _GroupChatConversationScreenState();
}

class _GroupChatConversationScreenState
    extends State<GroupChatConversationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Add sample group messages
    _messages.addAll([
      {
        'text': 'Hello everyone! How are you doing today?',
        'sender': 'Killam James',
        'time': '4:25 PM',
        'isMe': false,
      },
      {
        'text': 'I\'m doing great! Just finished the design mockups.',
        'sender': 'You',
        'time': '4:26 PM',
        'isMe': true,
      },
      {
        'text': 'Wow really Cool! Can\'t wait to see them.',
        'sender': 'Sarah Johnson',
        'time': '4:28 PM',
        'isMe': false,
      },
      {
        'text': 'Should we schedule a meeting tomorrow?',
        'sender': 'John Smith',
        'time': '4:29 PM',
        'isMe': false,
      },
    ]);
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'text': text,
        'sender': 'You',
        'time': _getCurrentTime(),
        'isMe': true,
      });
      _messageController.clear();
      _isTyping = false;
    });

    // Simulate reply after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'text': 'That sounds good!',
          'sender': 'Killam James',
          'time': _getCurrentTime(),
          'isMe': false,
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

  // ✅ EDIT BUTTON NAVIGATION TO EDIT GROUP CHAT SCREEN
  void _navigateToEditGroup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditGroupChatScreen(groupId: widget.groupId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.people,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.groupName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Group • 4 members',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // ✅ EDIT GROUP BUTTON - Navigates to EditGroupChatScreen
          IconButton(
            icon: const Icon(Iconsax.edit_2, size: 22),
            color: const Color(0xFF22C55E),
            onPressed: _navigateToEditGroup,
          ),
          IconButton(
              icon: const Icon(Icons.info_outline, size: 22),
              color: const Color(0xFF22C55E),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupInfoScreen(
                      groupId: widget.groupId,
                      groupName: widget.groupName,
                    ),
                  ),
                );
              }),
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
          if (_isTyping) _buildTypingIndicator(),

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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  message['sender'][0],
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
                // Sender name (for group messages)
                if (!isMe)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 4),
                    child: Text(
                      message['sender'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                // Message bubble
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
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
                    border:
                        !isMe ? Border.all(color: Colors.grey.shade300) : null,
                  ),
                  child: Text(
                    message['text'],
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),

                // Time
                const SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.only(
                    left: isMe ? 0 : 8,
                    right: isMe ? 8 : 0,
                  ),
                  child: Text(
                    message['time'],
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
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
              child: const Center(
                child: Text(
                  'K',
                  style: TextStyle(
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
            onPressed: () {},
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
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined,
                        color: Colors.grey),
                    onPressed: () {},
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
















































// // lib/features/chats/presentation/screens/group_chat_conversation_screen.dart
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class GroupChatConversationScreen extends StatefulWidget {
//   final String groupId;
//   final String groupName;

//   const GroupChatConversationScreen({
//     super.key,
//     required this.groupId,
//     required this.groupName,
//   });

//   @override
//   State<GroupChatConversationScreen> createState() =>
//       _GroupChatConversationScreenState();
// }

// class _GroupChatConversationScreenState
//     extends State<GroupChatConversationScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final List<Map<String, dynamic>> _messages = [];
//   bool _isTyping = false;

//   @override
//   void initState() {
//     super.initState();
//     // Add sample group messages
//     _messages.addAll([
//       {
//         'text': 'Hello everyone! How are you doing today?',
//         'sender': 'Killam James',
//         'time': '4:25 PM',
//         'isMe': false,
//       },
//       {
//         'text': 'I\'m doing great! Just finished the design mockups.',
//         'sender': 'You',
//         'time': '4:26 PM',
//         'isMe': true,
//       },
//       {
//         'text': 'Wow really Cool! Can\'t wait to see them.',
//         'sender': 'Sarah Johnson',
//         'time': '4:28 PM',
//         'isMe': false,
//       },
//       {
//         'text': 'Should we schedule a meeting tomorrow?',
//         'sender': 'John Smith',
//         'time': '4:29 PM',
//         'isMe': false,
//       },
//     ]);
//   }

//   void _sendMessage() {
//     final text = _messageController.text.trim();
//     if (text.isEmpty) return;

//     setState(() {
//       _messages.add({
//         'text': text,
//         'sender': 'You',
//         'time': _getCurrentTime(),
//         'isMe': true,
//       });
//       _messageController.clear();
//       _isTyping = false;
//     });

//     // Simulate reply after 1 second
//     Future.delayed(const Duration(seconds: 1), () {
//       setState(() {
//         _messages.add({
//           'text': 'That sounds good!',
//           'sender': 'Killam James',
//           'time': _getCurrentTime(),
//           'isMe': false,
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
//     // Navigate to edit group screen
//     // Navigator.push(context, MaterialPageRoute(
//     //   builder: (context) => EditGroupChatScreen(groupId: widget.groupId),
//     // ));
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
//               child: const Center(
//                 child: Icon(
//                   Icons.people,
//                   color: Colors.white,
//                   size: 20,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.groupName,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 const Text(
//                   'Group • 4 members',
//                   style: TextStyle(
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
//             icon: const Icon(Iconsax.edit_2, size: 22),
//             color: const Color(0xFF22C55E),
//             onPressed: _navigateToEditGroup,
//           ),
//           IconButton(
//             icon: const Icon(Icons.info_outline, size: 22),
//             color: const Color(0xFF22C55E),
//             onPressed: () {
//               // Show group info
//             },
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
//           if (_isTyping) _buildTypingIndicator(),

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
//         crossAxisAlignment: CrossAxisAlignment.start,
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
//                 child: Text(
//                   message['sender'][0],
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ),
//           if (!isMe) const SizedBox(width: 8),
//           Flexible(
//             child: Column(
//               crossAxisAlignment:
//                   isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//               children: [
//                 // Sender name (for group messages)
//                 if (!isMe)
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8, bottom: 4),
//                     child: Text(
//                       message['sender'],
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ),

//                 // Message bubble
//                 Container(
//                   constraints: BoxConstraints(
//                     maxWidth: MediaQuery.of(context).size.width * 0.7,
//                   ),
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
//                     border:
//                         !isMe ? Border.all(color: Colors.grey.shade300) : null,
//                   ),
//                   child: Text(
//                     message['text'],
//                     style: TextStyle(
//                       color: isMe ? Colors.white : Colors.black,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),

//                 // Time
//                 const SizedBox(height: 4),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: isMe ? 0 : 8,
//                     right: isMe ? 8 : 0,
//                   ),
//                   child: Text(
//                     message['time'],
//                     style: const TextStyle(
//                       fontSize: 10,
//                       color: Colors.grey,
//                     ),
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
//             child: const Center(
//               child: Text(
//                 'K',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14,
//                 ),
//               ),
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

























// // lib/features/chats/presentation/screens/group_chat_conversation_screen.dart
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:iconsax/iconsax.dart';

// // ==================== MODELS (INSIDE SCREEN) ====================
// class GroupMessage {
//   final String id;
//   final String senderId;
//   final String message;
//   final String? imageUrl;
//   final DateTime createdAt;
//   final List<String> reactions;

//   GroupMessage({
//     required this.id,
//     required this.senderId,
//     required this.message,
//     this.imageUrl,
//     required this.createdAt,
//     this.reactions = const [],

//   });
// }

// class GroupMember {
//   final String id;
//   final String userId;
//   final String groupId;

//   GroupMember({
//     required this.id,
//     required this.userId,
//     required this.groupId,
//   });
// }

// class Profile {
//   final String id;
//   final String fullName;
//   final String? avatarUrl;

//   Profile({
//     required this.id,
//     required this.fullName,
//     this.avatarUrl,
//   });
// }

// class TypingUser {
//   final String id;
//   final String name;

//   TypingUser({required this.id, required this.name});
// }

// // ==================== GROUP CHAT CONVERSATION SCREEN ====================
// class GroupChatConversationScreen extends StatefulWidget {
//   final String groupId;
  
//   const GroupChatConversationScreen({super.key, required this.groupId});

//   @override
//   State<GroupChatConversationScreen> createState() => _GroupChatConversationScreenState();
// }

// class _GroupChatConversationScreenState extends State<GroupChatConversationScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   final ScrollController _scrollController = ScrollController();
  
//   bool _isLoading = true;
//   bool _isSending = false;
//   bool _isUploading = false;
  
//   String _currentUserId = 'user_123'; // Replace with actual user ID
//   String _groupName = 'Design Team';
//   String? _groupAvatarUrl;
  
//   final List<GroupMessage> _messages = [];
//   final List<GroupMember> _members = [];
//   final Map<String, Profile> _memberProfiles = {};
//   final List<TypingUser> _typingUsers = [];
//   final Map<String, Map<String, List<String>>> _reactions = {};
  
//   @override
//   void initState() {
//     super.initState();
//     _loadGroupData();
//     _scrollController.addListener(_scrollListener);
//   }
  
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
  
//   void _scrollListener() {
//     if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
//         !_scrollController.position.outOfRange) {
//       // Load more messages
//     }
//   }
  
//   Future<void> _loadGroupData() async {
//     setState(() => _isLoading = true);
    
//     // Simulate API calls
//     await Future.delayed(const Duration(seconds: 1));
    
//     // Mock group info
//     _groupName = 'Design Team';
//     _groupAvatarUrl = 'https://api.dicebear.com/7.x/avataaars/svg?seed=design';
    
//     // Mock members
//     _members.addAll([
//       GroupMember(id: '1', userId: 'user_123', groupId: widget.groupId),
//       GroupMember(id: '2', userId: 'user_456', groupId: widget.groupId),
//       GroupMember(id: '3', userId: 'user_789', groupId: widget.groupId),
//     ]);
    
//     // Mock profiles
//     _memberProfiles.addAll({
//       'user_123': Profile(
//         id: 'user_123',
//         fullName: 'You',
//         avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=you',
//       ),
//       'user_456': Profile(
//         id: 'user_456',
//         fullName: 'Killam James',
//         avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=killam',
//       ),
//       'user_789': Profile(
//         id: 'user_789',
//         fullName: 'Sarah Johnson',
//         avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=sarah',
//       ),
//     });
    
//     // Mock messages
//     _messages.addAll([
//       GroupMessage(
//         id: '1',
//         senderId: 'user_456',
//         message: 'Hello everyone! How are you doing today?',
//         createdAt: DateTime.now().subtract(const Duration(hours: 2)),
//       ),
//       GroupMessage(
//         id: '2',
//         senderId: 'user_123',
//         message: 'I\'m doing great! Just finished the design mockups.',
//         createdAt: DateTime.now().subtract(const Duration(hours: 1)),
//       ),
//       GroupMessage(
//         id: '3',
//         senderId: 'user_789',
//         message: 'Wow really Cool! Can\'t wait to see them.',
//         createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
//       ),
//       GroupMessage(
//         id: '4',
//         senderId: 'user_456',
//         message: 'Should we schedule a meeting tomorrow?',
//         createdAt: DateTime.now().subtract(const Duration(minutes: 15)),
//       ),
//     ]);
    
//     setState(() => _isLoading = false);
    
//     // Scroll to bottom after loading
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _scrollToBottom();
//     });
//   }
  
//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }
  
//   Future<void> _sendMessage() async {
//     final text = _messageController.text.trim();
//     if (text.isEmpty) return;
    
//     setState(() => _isSending = true);
    
//     // Add message to list
//     final newMessage = GroupMessage(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       senderId: _currentUserId,
//       message: text,
//       createdAt: DateTime.now(),
//     );
    
//     setState(() {
//       _messages.add(newMessage);
//       _messageController.clear();
//     });
    
//     // Simulate network delay
//     await Future.delayed(const Duration(milliseconds: 500));
    
//     setState(() => _isSending = false);
//     _scrollToBottom();
//   }
  
//   Future<void> _pickAndUploadImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image == null) return;
    
//     setState(() => _isUploading = true);
    
//     // Simulate upload delay
//     await Future.delayed(const Duration(seconds: 2));
    
//     final imageMessage = GroupMessage(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       senderId: _currentUserId,
//       message: 'Sent an image',
//       imageUrl: 'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
//       createdAt: DateTime.now(),
//     );
    
//     setState(() {
//       _messages.add(imageMessage);
//       _isUploading = false;
//     });
    
//     _scrollToBottom();
//   }
  
//   void _handleReaction(String messageId, String emoji) {
//     setState(() {
//       final messageReactions = _reactions[messageId] ?? {};
//       final emojiUsers = messageReactions[emoji] ?? [];
      
//       if (emojiUsers.contains(_currentUserId)) {
//         // Remove reaction
//         final newUsers = emojiUsers.where((id) => id != _currentUserId).toList();
//         if (newUsers.isEmpty) {
//           messageReactions.remove(emoji);
//         } else {
//           messageReactions[emoji] = newUsers;
//         }
//       } else {
//         // Add reaction
//         messageReactions[emoji] = [...emojiUsers, _currentUserId];
//       }
      
//       if (messageReactions.isEmpty) {
//         _reactions.remove(messageId);
//       } else {
//         _reactions[messageId] = messageReactions;
//       }
//     });
//   }
  
//   void _startTyping() {
//     final currentUser = _memberProfiles[_currentUserId];
//     if (currentUser == null) return;
    
//     if (!_typingUsers.any((user) => user.id == _currentUserId)) {
//       setState(() {
//         _typingUsers.add(TypingUser(
//           id: _currentUserId,
//           name: currentUser.fullName,
//         ));
//       });
//     }
//   }
  
//   void _stopTyping() {
//     setState(() {
//       _typingUsers.removeWhere((user) => user.id == _currentUserId);
//     });
//   }
  
//   void _navigateToGroupSettings() {
//     // Navigate to edit group chat screen
//     // Navigator.push(context, MaterialPageRoute(
//     //   builder: (context) => EditGroupChatScreen(groupId: widget.groupId),
//     // ));
//   }
  
//   Profile? _getSenderProfile(String senderId) {
//     return _memberProfiles[senderId];
//   }
  
//   String _formatTime(DateTime dateTime) {
//     final hour = dateTime.hour % 12;
//     final minute = dateTime.minute;
//     final period = dateTime.hour < 12 ? 'AM' : 'PM';
//     return '${hour == 0 ? 12 : hour}:${minute.toString().padLeft(2, '0')} $period';
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFAFAFA),
//       body: Column(
//         children: [
//           // Header
//           _buildHeader(),
          
//           // Messages List
//           Expanded(
//             child: _isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : _buildMessagesList(),
//           ),
          
//           // Typing Indicator
//           if (_typingUsers.isNotEmpty) _buildTypingIndicator(),
          
//           // Input Area
//           _buildInputArea(),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           bottom: BorderSide(color: Color(0xFFE5E5E7), width: 1),
//         ),
//       ),
//       child: Row(
//         children: [
//           // Back Button
//           IconButton(
//             icon: const Icon(Iconsax.arrow_left, size: 24),
//             onPressed: () => Navigator.pop(context),
//           ),
          
//           // Group Avatar
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: const Color(0xFF22C55E).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: _groupAvatarUrl != null && _groupAvatarUrl!.isNotEmpty
//                 ? ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       _groupAvatarUrl!,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                 : const Center(
//                     child: Icon(
//                       Iconsax.people,
//                       color: Color(0xFF22C55E),
//                       size: 20,
//                     ),
//                   ),
//           ),
          
//           const SizedBox(width: 12),
          
//           // Group Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   _groupName,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF1A1A1A),
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   _typingUsers.isNotEmpty
//                       ? '${_typingUsers.first.name.split('@')[0]} is typing...'
//                       : '${_members.length} members',
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF737373),
//                   ),
//                 ),
//               ],
//             ),
//           ),
          
//           // More Options Menu
//           PopupMenuButton<String>(
//             icon: const Icon(Iconsax.more, size: 24, color: Color(0xFF1A1A1A)),
//             onSelected: (value) {
//               if (value == 'settings') {
//                 _navigateToGroupSettings();
//               }
//             },
//             itemBuilder: (BuildContext context) {
//               return [
//                 const PopupMenuItem<String>(
//                   value: 'settings',
//                   child: Row(
//                     children: [
//                       Icon(Iconsax.setting, size: 18),
//                       SizedBox(width: 8),
//                       Text('Group Settings'),
//                     ],
//                   ),
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildMessagesList() {
//     if (_messages.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Iconsax.people,
//               size: 64,
//               color: Color(0xFF737373),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'No messages yet',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Color(0xFF737373),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Start the conversation!',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       );
//     }
    
//     return ListView.builder(
//       controller: _scrollController,
//       padding: const EdgeInsets.all(16),
//       itemCount: _messages.length,
//       itemBuilder: (context, index) {
//         final message = _messages[index];
//         final isMe = message.senderId == _currentUserId;
//         final sender = _getSenderProfile(message.senderId);
        
//         return _buildMessageItem(message, isMe, sender);
//       },
//     );
//   }
  
//   Widget _buildMessageItem(GroupMessage message, bool isMe, Profile? sender) {
//     final messageReactions = _reactions[message.id] ?? {};
    
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           // Avatar (for others)
//           if (!isMe && sender != null)
//             Container(
//               width: 32,
//               height: 32,
//               margin: const EdgeInsets.only(right: 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF22C55E).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: sender.avatarUrl != null && sender.avatarUrl!.isNotEmpty
//                   ? ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         sender.avatarUrl!,
//                         fit: BoxFit.cover,
//                       ),
//                     )
//                   : Center(
//                       child: Text(
//                         sender.fullName[0],
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF22C55E),
//                         ),
//                       ),
//                     ),
//             ),
          
//           // Message Content
//           Flexible(
//             child: Column(
//               crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//               children: [
//                 // Sender Name (for others)
//                 if (!isMe && sender != null)
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8, bottom: 4),
//                     child: Text(
//                       sender.fullName,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Color(0xFF737373),
//                       ),
//                     ),
//                   ),
                
//                 // Message Bubble
//                 Container(
//                   constraints: BoxConstraints(
//                     maxWidth: MediaQuery.of(context).size.width * 0.7,
//                   ),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: isMe ? const Color(0xFF22C55E) : Colors.white,
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
//                     border: !isMe
//                         ? Border.all(color: const Color(0xFFE5E5E7), width: 1)
//                         : null,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Image
//                       if (message.imageUrl != null && message.imageUrl!.isNotEmpty)
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.network(
//                             message.imageUrl!,
//                             width: double.infinity,
//                             height: 200,
//                             fit: BoxFit.cover,
//                             loadingBuilder: (context, child, loadingProgress) {
//                               if (loadingProgress == null) return child;
//                               return Container(
//                                 width: double.infinity,
//                                 height: 200,
//                                 color: Colors.grey[200],
//                                 child: const Center(
//                                   child: CircularProgressIndicator(),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
                      
//                       // Text Message
//                       if (message.message.isNotEmpty && message.message != 'Sent an image')
//                         Text(
//                           message.message,
//                           style: TextStyle(
//                             color: isMe ? Colors.white : const Color(0xFF1A1A1A),
//                             fontSize: 14,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
                
//                 // Time and Reactions
//                 Container(
//                   margin: const EdgeInsets.only(top: 4),
//                   child: Row(
//                     mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         _formatTime(message.createdAt),
//                         style: const TextStyle(
//                           fontSize: 11,
//                           color: Color(0xFF737373),
//                         ),
//                       ),
                      
//                       // Reactions
//                       if (messageReactions.isNotEmpty)
//                         Row(
//                           children: messageReactions.entries.map((entry) {
//                             return GestureDetector(
//                               onTap: () => _handleReaction(message.id, entry.key),
//                               child: Container(
//                                 margin: const EdgeInsets.only(left: 4),
//                                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey[100],
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       entry.key,
//                                       style: const TextStyle(fontSize: 12),
//                                     ),
//                                     const SizedBox(width: 2),
//                                     Text(
//                                       entry.value.length.toString(),
//                                       style: const TextStyle(
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                     ],
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
//           // Avatar
//           Container(
//             width: 32,
//             height: 32,
//             decoration: BoxDecoration(
//               color: const Color(0xFF22C55E).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: const Center(
//               child: Icon(
//                 Iconsax.people,
//                 size: 16,
//                 color: Color(0xFF22C55E),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
          
//           // Typing Dots
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: const Color(0xFFE5E5E7), width: 1),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   width: 8,
//                   height: 8,
//                   margin: const EdgeInsets.only(right: 4),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF737373),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 Container(
//                   width: 8,
//                   height: 8,
//                   margin: const EdgeInsets.only(right: 4),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF737373),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 Container(
//                   width: 8,
//                   height: 8,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF737373),
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
  
//   Widget _buildInputArea() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           top: BorderSide(color: Color(0xFFE5E5E7), width: 1),
//         ),
//       ),
//       child: Row(
//         children: [
//           // Image Button
//           IconButton(
//             icon: Icon(
//               Iconsax.gallery,
//               color: Colors.grey[600],
//               size: 24,
//             ),
//             onPressed: _isUploading ? null : _pickAndUploadImage,
//           ),
          
//           // Message Input
//           Expanded(
//             child: Container(
//               height: 44,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFAFAFA),
//                 borderRadius: BorderRadius.circular(22),
//               ),
//               child: Row(
//                 children: [
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       onChanged: (text) {
//                         if (text.isNotEmpty) {
//                           _startTyping();
//                         } else {
//                           _stopTyping();
//                         }
//                       },
//                       onSubmitted: (_) => _sendMessage(),
//                       decoration: const InputDecoration(
//                         hintText: 'Type a message...',
//                         border: InputBorder.none,
//                         hintStyle: TextStyle(color: Color(0xFF737373)),
//                       ),
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF1A1A1A),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: Icon(
//                       Iconsax.emoji_happy,
//                       color: Colors.grey[600],
//                       size: 20,
//                     ),
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
//               color: _messageController.text.trim().isEmpty && !_isUploading
//                   ? Colors.grey[300]
//                   : const Color(0xFF22C55E),
//               borderRadius: BorderRadius.circular(22),
//             ),
//             child: IconButton(
//               icon: _isSending || _isUploading
//                   ? const SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(
//                         color: Colors.white,
//                         strokeWidth: 2,
//                       ),
//                     )
//                   : const Icon(
//                       Iconsax.send_1,
//                       color: Colors.white,
//                       size: 20,
//                     ),
//               onPressed: (_messageController.text.trim().isEmpty && !_isUploading)
//                   ? null
//                   : _sendMessage,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }