// lib/features/chats/presentation/screens/chats_screen.dart - UPDATED VERSION
import 'package:flutter/material.dart';
import 'package:xirfadsan_receipt/features/chats/presentation/screens/ChatConversation.dart';
import 'package:xirfadsan_receipt/features/chats/presentation/screens/CreateGroupChat.dart';
import 'package:xirfadsan_receipt/features/chats/presentation/screens/Group_Chat_Conversation.dart';
import 'package:xirfadsan_receipt/features/chats/presentation/screens/chat_item.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Sample chat data
  final List<ChatItem> _chats = [
    const ChatItem(
      id: '1',
      name: 'Killam James',
      lastMessage: 'Typing...',
      time: '4:30 PM',
      unreadCount: 2,
      isOnline: true,
      isTyping: true,
      isGroup: false,
    ),
    const ChatItem(
      id: '2',
      name: 'Design Team',
      lastMessage: 'Wow really Cool',
      time: '4:30 PM',
      unreadCount: 0,
      isOnline: false,
      isTyping: false,
      isGroup: true,
    ),
    const ChatItem(
      id: '3',
      name: 'John Smith',
      lastMessage: 'See you tomorrow!',
      time: '2:15 PM',
      unreadCount: 0,
      isOnline: false,
      isTyping: false,
      isGroup: false,
    ),
    const ChatItem(
      id: '4',
      name: 'Sarah Johnson',
      lastMessage: 'Thanks for the update!',
      time: '1:30 PM',
      unreadCount: 1,
      isOnline: true,
      isTyping: false,
      isGroup: false,
    ),
  ];

  List<ChatItem> get _filteredChats {
    if (_searchController.text.isEmpty) return _chats;
    return _chats.where((chat) {
      return chat.name.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      // appBar: _buildAppBar(),
      body: Column(
        children: [
          // Search Bar
          _buildSearchBar(),

          // Chats List
          Expanded(
            child: _buildChatsList(),
          ),
        ],
      ),

      // ✅ FLOATING ACTION BUTTON FOR CREATE GROUP CHAT
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToCreateGroupChat(context);
        },
        backgroundColor: const Color(0xFF22C55E),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }

  // AppBar _buildAppBar() {
  //   return AppBar(
  //     backgroundColor: const Color(0xFFFAFAFA),
  //     elevation: 0,
  //     toolbarHeight: 100,
  //     title: Padding(
  //       padding: const EdgeInsets.only(top: 20),
  //       child: Row(
  //         children: [
  //           // Profile
  //           Container(
  //             width: 40,
  //             height: 40,
  //             decoration: BoxDecoration(
  //               color: const Color(0xFF22C55E),
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             child: const Icon(
  //               Icons.person,
  //               color: Colors.white,
  //               size: 24,
  //             ),
  //           ),
  //           const SizedBox(width: 12),

  //           // Location
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Row(
  //                   children: [
  //                     Icon(
  //                       Icons.location_on,
  //                       color: Color(0xFF22C55E),
  //                       size: 16,
  //                     ),
  //                     SizedBox(width: 4),
  //                     Text(
  //                       '2. Bhadir, Mogadishu',
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w600,
  //                         color: Color(0xFF1A1A1A),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 2),
  //                 Text(
  //                   'Search chats...',
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     color: Colors.grey[600],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),

  //           // Notification
  //           Container(
  //             width: 40,
  //             height: 40,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(12),
  //               border: Border.all(color: Colors.grey[300]!),
  //             ),
  //             child: const Icon(
  //               Icons.notifications_none,
  //               color: Color(0xFF1A1A1A),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Search Input
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: 'Search chats...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    color: const Color(0xFF22C55E),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Add Button (Now removed since we have FAB)
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                // Now using FAB instead
                _navigateToCreateGroupChat(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatsList() {
    if (_filteredChats.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No chats found',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _filteredChats.length,
      itemBuilder: (context, index) {
        final chat = _filteredChats[index];
        return _buildChatItem(chat);
      },
    );
  }

  Widget _buildChatItem(ChatItem chat) {
    return ListTile(
      onTap: () {
        _navigateToChat(chat);
      },
      leading: Stack(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(28),
            ),
            child: Center(
              child: chat.isGroup
                  ? const Icon(Icons.people, color: Color(0xFF22C55E), size: 24)
                  : Text(
                      chat.name[0],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF22C55E),
                      ),
                    ),
            ),
          ),
          if (chat.isOnline && !chat.isGroup)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        chat.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        chat.lastMessage,
        style: TextStyle(
          fontSize: 14,
          color: chat.isTyping ? const Color(0xFF22C55E) : Colors.grey[600],
          fontWeight: chat.isTyping ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            chat.time,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          if (chat.unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                chat.unreadCount.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ✅ METHOD TO NAVIGATE TO CREATE GROUP CHAT
  void _navigateToCreateGroupChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateGroupChatScreen(),
      ),
    );
  }

  // ✅ CORRECT NAVIGATION METHOD
  void _navigateToChat(ChatItem chat) {
    if (chat.isGroup) {
      // Navigate to Group Chat Conversation
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GroupChatConversationScreen(
            groupId: chat.id,
            groupName: chat.name,
          ),
        ),
      );
    } else {
      // Navigate to Individual Chat Conversation
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatConversation(chat: chat),
        ),
      );
    }
  }
}
