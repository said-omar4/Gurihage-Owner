// lib/features/chats/presentation/screens/group_info_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/features/chats/presentation/screens/EditGroupChat.dart';

class GroupInfoScreen extends StatefulWidget {
  final String groupId;
  final String groupName;

  const GroupInfoScreen({
    super.key,
    required this.groupId,
    required this.groupName,
  });

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  final List<Map<String, dynamic>> _members = [];
  final List<Map<String, dynamic>> _mediaItems = [];
  final List<Map<String, dynamic>> _groupSettings = [];
  bool _muteNotifications = false;
  bool _isAdmin = true; // Assuming current user is admin

  @override
  void initState() {
    super.initState();
    _loadGroupData();
  }

  void _loadGroupData() {
    // Load members
    _members.addAll([
      {
        'id': '1',
        'name': 'You',
        'role': 'Admin',
        'avatar': 'https://api.dicebear.com/7.x/avataaars/svg?seed=you',
        'isOnline': true,
      },
      {
        'id': '2',
        'name': 'Killam James',
        'role': 'Member',
        'avatar': 'https://api.dicebear.com/7.x/avataaars/svg?seed=killam',
        'isOnline': true,
      },
      {
        'id': '3',
        'name': 'Sarah Johnson',
        'role': 'Member',
        'avatar': 'https://api.dicebear.com/7.x/avataaars/svg?seed=sarah',
        'isOnline': false,
      },
      {
        'id': '4',
        'name': 'John Smith',
        'role': 'Member',
        'avatar': 'https://api.dicebear.com/7.x/avataaars/svg?seed=john',
        'isOnline': false,
      },
      {
        'id': '5',
        'name': 'Ahmed Mohamed',
        'role': 'Member',
        'avatar': 'https://api.dicebear.com/7.x/avataaars/svg?seed=ahmed',
        'isOnline': true,
      },
    ]);

    // Load media items
    _mediaItems.addAll([
      {
        'id': '1',
        'type': 'image',
        'url':
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=400',
        'sender': 'Killam James',
        'time': '2 days ago',
      },
      {
        'id': '2',
        'type': 'image',
        'url':
            'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400',
        'sender': 'You',
        'time': '3 days ago',
      },
      {
        'id': '3',
        'type': 'image',
        'url':
            'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=400',
        'sender': 'Sarah Johnson',
        'time': '1 week ago',
      },
      {
        'id': '4',
        'type': 'image',
        'url':
            'https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?w=400',
        'sender': 'John Smith',
        'time': '2 weeks ago',
      },
    ]);

    // Load group settings
    _groupSettings.addAll([
      {
        'id': '1',
        'title': 'Edit Group',
        'icon': Iconsax.edit_2,
        'color': Color(0xFF22C55E),
      },
      {
        'id': '2',
        'title': 'Group Settings',
        'icon': Iconsax.setting,
        'color': Color(0xFF3B82F6),
      },
      {
        'id': '3',
        'title': 'Media, Links & Docs',
        'icon': Iconsax.gallery,
        'color': Color(0xFF8B5CF6),
      },
      {
        'id': '4',
        'title': 'Search',
        'icon': Iconsax.search_normal,
        'color': Color(0xFFEF4444),
      },
    ]);
  }

  void _navigateToEditGroup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditGroupChatScreen(groupId: widget.groupId),
      ),
    );
  }

  void _showMemberOptions(Map<String, dynamic> member) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Iconsax.profile_circle,
                    color: Color(0xFF22C55E)),
                title: Text('View ${member['name']}\'s Profile'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to member profile
                },
              ),
              if (_isAdmin && member['role'] != 'Admin')
                ListTile(
                  leading: const Icon(Iconsax.user_remove, color: Colors.red),
                  title: Text('Remove ${member['name']}'),
                  onTap: () {
                    Navigator.pop(context);
                    _removeMember(member['id']);
                  },
                ),
              if (_isAdmin && member['role'] != 'Admin')
                ListTile(
                  leading: const Icon(Iconsax.crown, color: Color(0xFFFFD700)),
                  title: Text('Make ${member['name']} Admin'),
                  onTap: () {
                    Navigator.pop(context);
                    _makeAdmin(member['id']);
                  },
                ),
              ListTile(
                leading: const Icon(Iconsax.message, color: Color(0xFF22C55E)),
                title: Text('Message ${member['name']}'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to private chat
                },
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeMember(String memberId) {
    setState(() {
      _members.removeWhere((member) => member['id'] == memberId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Member removed from group'),
        backgroundColor: Color(0xFF22C55E),
      ),
    );
  }

  void _makeAdmin(String memberId) {
    setState(() {
      final member = _members.firstWhere((m) => m['id'] == memberId);
      member['role'] = 'Admin';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Member promoted to admin'),
        backgroundColor: Color(0xFF22C55E),
      ),
    );
  }

  void _addNewMember() {
    // Navigate to add members screen
    // Navigator.push(context, MaterialPageRoute(
    //   builder: (context) => AddMembersScreen(groupId: widget.groupId),
    // ));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add members functionality coming soon'),
        backgroundColor: Color(0xFF22C55E),
      ),
    );
  }

  void _leaveGroup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Leave Group?'),
        content: const Text(
            'Are you sure you want to leave this group? You will no longer receive messages from this group.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to chats screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('You have left the group'),
                  backgroundColor: Color(0xFF22C55E),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Group Info',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Group Header
            _buildGroupHeader(),

            // Members Section
            _buildMembersSection(),

            // Media Section
            _buildMediaSection(),

            // Group Settings
            _buildGroupSettings(),

            // Leave Group Button
            _buildLeaveGroupButton(),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          // Group Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Iconsax.people,
              size: 40,
              color: Color(0xFF22C55E),
            ),
          ),
          const SizedBox(height: 12),

          // Group Name
          Text(
            widget.groupName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),

          // Member Count
          Text(
            '${_members.length} members',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),

          // Group Created Info
          Text(
            'Created on ${_formatDate(DateTime.now().subtract(const Duration(days: 30)))}',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersSection() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Members',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (_isAdmin)
                  TextButton.icon(
                    onPressed: _addNewMember,
                    icon: const Icon(Iconsax.user_add, size: 16),
                    label: const Text('Add'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF22C55E),
                    ),
                  ),
              ],
            ),
          ),

          // Members List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _members.length,
            itemBuilder: (context, index) {
              final member = _members[index];
              return _buildMemberItem(member);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMemberItem(Map<String, dynamic> member) {
    return ListTile(
      onTap: () => _showMemberOptions(member),
      leading: Stack(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: member['avatar'] != null &&
                    member['avatar'].toString().isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      member['avatar'],
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: Text(
                      member['name'][0],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF22C55E),
                      ),
                    ),
                  ),
          ),
          if (member['isOnline'])
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        member['name'],
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        member['role'],
        style: TextStyle(
          fontSize: 12,
          color:
              member['role'] == 'Admin' ? const Color(0xFF22C55E) : Colors.grey,
          fontWeight:
              member['role'] == 'Admin' ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: member['id'] == '1' // Current user
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'You',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            )
          : const Icon(Iconsax.more, size: 20, color: Colors.grey),
    );
  }

  Widget _buildMediaSection() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Media, Links & Files',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Media Grid
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _mediaItems.length,
              itemBuilder: (context, index) {
                final media = _mediaItems[index];
                return _buildMediaItem(media);
              },
            ),
          ),

          // View All Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_mediaItems.length} items',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to full media gallery
                  },
                  child: const Text(
                    'View all',
                    style: TextStyle(
                      color: Color(0xFF22C55E),
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

  Widget _buildMediaItem(Map<String, dynamic> media) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[100],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          media['url'],
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGroupSettings() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      color: Colors.white,
      child: Column(
        children: [
          // Notification Settings
          SwitchListTile(
            title: const Text(
              'Mute Notifications',
              style: TextStyle(fontSize: 16),
            ),
            subtitle: const Text(
              'You won\'t receive notifications from this group',
              style: TextStyle(fontSize: 12),
            ),
            value: _muteNotifications,
            onChanged: (value) {
              setState(() {
                _muteNotifications = value;
              });
            },
            activeColor: const Color(0xFF22C55E),
          ),

          // Settings List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _groupSettings.length,
            itemBuilder: (context, index) {
              final setting = _groupSettings[index];
              return _buildSettingItem(setting);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(Map<String, dynamic> setting) {
    return ListTile(
      onTap: () {
        if (setting['id'] == '1') {
          _navigateToEditGroup();
        }
      },
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: setting['color'].withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          setting['icon'],
          color: setting['color'],
          size: 20,
        ),
      ),
      title: Text(
        setting['title'],
        style: const TextStyle(fontSize: 16),
      ),
      trailing: const Icon(Iconsax.arrow_right_3, size: 20, color: Colors.grey),
    );
  }

  Widget _buildLeaveGroupButton() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: _leaveGroup,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Leave Group'),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
