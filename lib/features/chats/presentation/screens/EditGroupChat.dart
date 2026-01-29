// lib/features/chats/presentation/screens/edit_group_chat_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';

// ==================== MODELS (INSIDE SCREEN) ====================
class GroupChat {
  final String id;
  final String name;
  final String? avatarUrl;
  final String ownerId;
  final DateTime createdAt;
  final DateTime updatedAt;

  GroupChat({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
  });
}

class GroupMember {
  final String id;
  final String userId;
  final String groupId;

  GroupMember({
    required this.id,
    required this.userId,
    required this.groupId,
  });
}

class Profile {
  final String id;
  final String fullName;
  final String? avatarUrl;
  final String? email;

  Profile({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    this.email,
  });
}

// ==================== EDIT GROUP CHAT SCREEN ====================
class EditGroupChatScreen extends StatefulWidget {
  final String groupId;

  const EditGroupChatScreen({super.key, required this.groupId});

  @override
  State<EditGroupChatScreen> createState() => _EditGroupChatScreenState();
}

class _EditGroupChatScreenState extends State<EditGroupChatScreen> {
  final TextEditingController _groupNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  bool _isLoading = true;
  bool _isSaving = false;
  bool _isUploading = false;
  bool _isDeleting = false;
  String? _avatarUrl;

  late GroupChat _group;
  final List<GroupMember> _members = [];
  final List<Profile> _memberProfiles = [];
  String? _currentUserId = 'current_user_123'; // Replace with actual user ID

  bool get _isOwner => _group.ownerId == _currentUserId;

  @override
  void initState() {
    super.initState();
    _fetchGroupData();
  }

  Future<void> _fetchGroupData() async {
    setState(() => _isLoading = true);

    // Simulate API calls
    await Future.delayed(const Duration(seconds: 1));

    // Mock group data
    _group = GroupChat(
      id: widget.groupId,
      name: 'Design Team',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=design',
      ownerId: 'current_user_123',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Mock members
    _members.addAll([
      GroupMember(id: '1', userId: 'current_user_123', groupId: widget.groupId),
      GroupMember(id: '2', userId: 'user_456', groupId: widget.groupId),
      GroupMember(id: '3', userId: 'user_789', groupId: widget.groupId),
    ]);

    // Mock profiles
    _memberProfiles.addAll([
      Profile(
        id: 'current_user_123',
        fullName: 'You',
        avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=you',
        email: 'you@example.com',
      ),
      Profile(
        id: 'user_456',
        fullName: 'Killam James',
        avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=killam',
        email: 'killam@example.com',
      ),
      Profile(
        id: 'user_789',
        fullName: 'Sarah Johnson',
        avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=sarah',
        email: 'sarah@example.com',
      ),
    ]);

    _groupNameController.text = _group.name;
    _avatarUrl = _group.avatarUrl;

    setState(() => _isLoading = false);
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _uploadImage(File(image.path));
    }
  }

  Future<void> _uploadImage(File image) async {
    setState(() => _isUploading = true);

    // Simulate upload
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _avatarUrl =
          'https://api.dicebear.com/7.x/avataaars/svg?seed=new${DateTime.now().millisecondsSinceEpoch}';
      _isUploading = false;
    });

    _showSnackBar('Image uploaded', 'Group avatar has been updated');
  }

  Future<void> _saveChanges() async {
    final groupName = _groupNameController.text.trim();

    if (groupName.isEmpty) {
      _showError('Invalid name', 'Group name cannot be empty');
      return;
    }

    setState(() => _isSaving = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    _group = GroupChat(
      id: _group.id,
      name: groupName,
      avatarUrl: _avatarUrl,
      ownerId: _group.ownerId,
      createdAt: _group.createdAt,
      updatedAt: DateTime.now(),
    );

    setState(() => _isSaving = false);

    _showSnackBar('Group updated', 'Group details have been saved');

    Navigator.pop(context);
  }

  Future<void> _removeMember(String memberId, String userId) async {
    if (userId == _group.ownerId) {
      _showError('Cannot remove owner', 'The group owner cannot be removed');
      return;
    }

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    _members.removeWhere((member) => member.id == memberId);
    _memberProfiles.removeWhere((profile) => profile.id == userId);

    setState(() {});

    _showSnackBar('Member removed', 'Member has been removed from the group');
  }

  Future<void> _deleteGroup() async {
    setState(() => _isDeleting = true);

    // Simulate API calls
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isDeleting = false);

    _showSnackBar('Group deleted', 'The group has been permanently deleted');

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _showError(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(message),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSnackBar(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(message),
          ],
        ),
        backgroundColor: const Color(0xFF22C55E),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _showDeleteConfirmation() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Iconsax.warning_2, color: Colors.red),
              const SizedBox(width: 8),
              const Text('Delete Group?'),
            ],
          ),
          content: const Text(
            'This action cannot be undone. This will permanently delete the group and all its messages.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteGroup();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToAddMembers() {
    // Navigate to add members screen
    // Navigator.push(context, MaterialPageRoute(builder: (context) => AddMembersScreen(groupId: widget.groupId)));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Group Avatar
              if (_isOwner) _buildGroupAvatar(),
              const SizedBox(height: 24),

              // Group Name
              _buildGroupNameCard(),
              const SizedBox(height: 24),

              // Members
              _buildMembersCard(),
              const SizedBox(height: 24),

              // Delete Group Button
              if (_isOwner) _buildDeleteButton(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFFAFAFA),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Iconsax.arrow_left, color: Color(0xFF1A1A1A)),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Edit Group',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1A1A),
        ),
      ),
      actions: [
        if (_isOwner)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
              onPressed: _isSaving ? null : _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF22C55E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Save'),
            ),
          ),
      ],
    );
  }

  Widget _buildGroupAvatar() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: const Color(0xFF22C55E).withOpacity(0.3), width: 4),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(46),
                child: _avatarUrl != null && _avatarUrl!.isNotEmpty
                    ? Image.network(
                        _avatarUrl!,
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
                      )
                    : Container(
                        color: const Color(0xFF22C55E).withOpacity(0.1),
                        child: const Center(
                          child: Icon(
                            Iconsax.people,
                            size: 40,
                            color: Color(0xFF22C55E),
                          ),
                        ),
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: IconButton(
                  onPressed: _isUploading ? null : _pickImage,
                  icon: _isUploading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Iconsax.camera,
                          size: 16, color: Colors.white),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Tap to change photo',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildGroupNameCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Group Name',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: _groupNameController,
                enabled: _isOwner,
                decoration: const InputDecoration(
                  hintText: 'Enter group name',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembersCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Members (${_members.length})',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
                if (_isOwner)
                  OutlinedButton(
                    onPressed: _navigateToAddMembers,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF22C55E),
                      side: const BorderSide(color: Color(0xFF22C55E)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(Iconsax.user_add, size: 16),
                        SizedBox(width: 4),
                        Text('Add'),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _memberProfiles.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final profile = _memberProfiles[index];
                final isGroupOwner = profile.id == _group.ownerId;
                final member =
                    _members.firstWhere((m) => m.userId == profile.id);

                return _buildMemberItem(profile, isGroupOwner, member);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberItem(
      Profile profile, bool isGroupOwner, GroupMember member) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF22C55E).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: profile.avatarUrl != null && profile.avatarUrl!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    profile.avatarUrl!,
                    fit: BoxFit.cover,
                  ),
                )
              : Center(
                  child: Text(
                    profile.fullName[0],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF22C55E),
                    ),
                  ),
                ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.fullName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              Text(
                isGroupOwner ? 'Owner' : 'Member',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        if (_isOwner && !isGroupOwner)
          IconButton(
            onPressed: () => _removeMember(member.id, profile.id),
            icon: const Icon(Iconsax.user_remove, color: Colors.red),
          ),
      ],
    );
  }

  Widget _buildDeleteButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isDeleting ? null : _showDeleteConfirmation,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: _isDeleting
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text('Deleting...'),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.trash, size: 20),
                  SizedBox(width: 8),
                  Text('Delete Group'),
                ],
              ),
      ),
    );
  }
}
