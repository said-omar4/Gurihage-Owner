// lib/features/profile/presentation/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/features/profile/presentation/screens/FAQ.dart';
import 'package:xirfadsan_receipt/features/profile/presentation/screens/call_center.dart';
import 'package:xirfadsan_receipt/features/profile/presentation/screens/change_password.dart';
import 'package:xirfadsan_receipt/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:xirfadsan_receipt/features/profile/presentation/screens/help_support.dart';
import 'package:xirfadsan_receipt/features/profile/presentation/screens/notification_settings.dart';
import 'package:xirfadsan_receipt/features/profile/presentation/screens/notifications.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _passwordEnabled = true;

  final String userName = "Said-Omar Ahmed";
  final String userEmail = "said4656@gmail.com";

  Future<void> _showLogoutDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement logout logic here
              print('User logged out');
              // Navigate to login screen
              // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Color(0xFFEF4444),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          // padding: const EdgeInsets.only(bottom: 80, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Card
              Container(
                // margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    // Avatar
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF22C55E).withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor:
                            const Color(0xFF22C55E).withOpacity(0.1),
                        child: const Text(
                          'S',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF22C55E),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // User Name
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // User Email
                    Text(
                      userEmail,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Edit Profile Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileScreen(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF22C55E)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF22C55E),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ACCOUNT Section
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                child: Text(
                  'ACCOUNT',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 1,
                  ),
                ),
              ),

              // Account Items
              Container(
                // margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Iconsax.user,
                      label: 'Edit Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfileScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    _buildMenuItem(
                      icon: Iconsax.lock,
                      label: 'Password',
                      hasSwitch: true,
                      onSwitchChanged: (value) {
                        setState(() {
                          _passwordEnabled = value;
                        });
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    _buildMenuItem(
                      icon: Iconsax.notification,
                      label: 'Notifications',
                      onTap: () {
                        // Two options: Notifications List or Notification Settings
                        _showNotificationsOptions(context);
                      },
                    ),
                  ],
                ),
              ),

              // SUPPORT & ABOUT Section
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 24, bottom: 8),
                child: Text(
                  'SUPPORT & ABOUT',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 1,
                  ),
                ),
              ),

              // Support Items
              Container(
                // margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: Iconsax.call,
                      label: 'Call Center',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CallCenterScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    _buildMenuItem(
                      icon: Iconsax.message_question,
                      label: 'FAQ Questions',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FaqScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFF1F5F9)),
                    _buildMenuItem(
                      icon: Iconsax.info_circle,
                      label: 'Help Support',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpSupportScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // ACTIONS Section
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 24, bottom: 8),
                child: Text(
                  'ACTIONS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 1,
                  ),
                ),
              ),

              // Logout Button
              Container(
                // margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFFECACA),
                    width: 1,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _showLogoutDialog,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEE2E2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Iconsax.logout,
                              size: 20,
                              color: Color(0xFFEF4444),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFEF4444),
                              ),
                            ),
                          ),
                          const Icon(
                            Iconsax.arrow_right_3,
                            size: 20,
                            color: Color(0xFFEF4444),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // App Version
              const Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    bool hasSwitch = false,
    bool switchValue = false,
    ValueChanged<bool>? onSwitchChanged,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: const Color(0xFF22C55E),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              if (hasSwitch)
                Switch(
                  value: switchValue,
                  onChanged: onSwitchChanged,
                  activeColor: const Color(0xFF22C55E),
                  inactiveTrackColor: const Color(0xFFCBD5E1),
                )
              else
                const Icon(
                  Iconsax.arrow_right_3,
                  size: 20,
                  color: Color(0xFFCBD5E1),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Header
  // Container(
  //   padding: const EdgeInsets.all(16),
  //   decoration: BoxDecoration(
  //     color: Colors.white,
  //     border: Border(
  //       bottom: BorderSide(
  //         color: Colors.grey.shade200,
  //         width: 1,
  //       ),
  //     ),
  //   ),
  //   child: Row(
  //     children: [
  //       IconButton(
  //         icon: const Icon(
  //           Icons.arrow_back_ios_new_rounded,
  //           size: 20,
  //           color: Colors.black,
  //         ),
  //         onPressed: () => Navigator.pop(context),
  //       ),
  //       const SizedBox(width: 8),
  //       const Text(
  //         'Profile',
  //         style: TextStyle(
  //           fontSize: 20,
  //           fontWeight: FontWeight.w700,
  //           color: Colors.black,
  //         ),
  //       ),
  //       const Spacer(),
  //       IconButton(
  //         icon: const Icon(
  //           Icons.more_vert_rounded,
  //           color: Colors.black,
  //         ),
  //         onPressed: () {
  //           // Show more options
  //           _showMoreOptions(context);
  //         },
  //       ),
  //     ],
  //   ),
  // ),
  // void _showMoreOptions(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return SafeArea(
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const SizedBox(height: 12),
  //             Container(
  //               width: 40,
  //               height: 4,
  //               decoration: BoxDecoration(
  //                 color: Colors.grey.shade300,
  //                 borderRadius: BorderRadius.circular(2),
  //               ),
  //             ),
  //             const SizedBox(height: 16),
  //             const Text(
  //               'More Options',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //             const SizedBox(height: 16),
  //             _buildBottomSheetItem(
  //               icon: Iconsax.setting_2,
  //               label: 'App Settings',
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 print('Navigate to App Settings');
  //               },
  //             ),
  //             _buildBottomSheetItem(
  //               icon: Iconsax.shield_tick,
  //               label: 'Privacy & Security',
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 print('Navigate to Privacy & Security');
  //               },
  //             ),
  //             _buildBottomSheetItem(
  //               icon: Iconsax.document_text,
  //               label: 'Terms & Conditions',
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 print('Navigate to Terms & Conditions');
  //               },
  //             ),
  //             const SizedBox(height: 20),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showNotificationsOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              _buildBottomSheetItem(
                icon: Iconsax.notification,
                label: 'View Notifications',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsScreen(),
                    ),
                  );
                },
              ),
              _buildBottomSheetItem(
                icon: Iconsax.setting_2,
                label: 'Notification Settings',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationSettingsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(icon, size: 22, color: const Color(0xFF22C55E)),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(
                Iconsax.arrow_right_3,
                size: 18,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
