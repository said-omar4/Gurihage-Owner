// lib/features/call_history/screens/call_history_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:xirfadsan_receipt/appbar.dart';
import 'package:xirfadsan_receipt/core/theme/app_theme.dart';

class CallHistoryScreen extends StatefulWidget {
  const CallHistoryScreen({super.key});

  @override
  State<CallHistoryScreen> createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  bool _isLoading = true;
  bool _isRefreshing = false;
  final List<Map<String, dynamic>> _calls = [];
  final String _currentUserId = 'user1'; // Replace with actual user ID

  @override
  void initState() {
    super.initState();
    _loadCallHistory();
  }

  Future<void> _loadCallHistory() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(seconds: 1));

    final List<Map<String, dynamic>> mockCalls = [
      {
        'id': '1',
        'caller_id': 'user1',
        'receiver_id': 'user2',
        'call_type': 'voice',
        'status': 'answered',
        'duration_seconds': 240,
        'started_at': DateTime.now().subtract(const Duration(hours: 2)),
        'other_user': {
          'full_name': 'Said-Omar Ahmed',
          'avatar_url':
              'https://api.dicebear.com/7.x/avataaars/svg?seed=saidomar',
        }
      },
      {
        'id': '2',
        'caller_id': 'user3',
        'receiver_id': 'user1',
        'call_type': 'video',
        'status': 'missed',
        'duration_seconds': 0,
        'started_at': DateTime.now().subtract(const Duration(hours: 5)),
        'other_user': {
          'full_name': 'Fatima Ali',
          'avatar_url':
              'https://api.dicebear.com/7.x/avataaars/svg?seed=fatima',
        }
      },
      {
        'id': '3',
        'caller_id': 'user1',
        'receiver_id': 'user4',
        'call_type': 'voice',
        'status': 'ended',
        'duration_seconds': 180,
        'started_at': DateTime.now().subtract(const Duration(days: 1)),
        'other_user': {
          'full_name': 'Mohamed Hassan',
          'avatar_url':
              'https://api.dicebear.com/7.x/avataaars/svg?seed=mohamed',
        }
      },
      {
        'id': '4',
        'caller_id': 'user5',
        'receiver_id': 'user1',
        'call_type': 'voice',
        'status': 'rejected',
        'duration_seconds': 0,
        'started_at': DateTime.now().subtract(const Duration(days: 2)),
        'other_user': {
          'full_name': 'Aisha Mohamed',
          'avatar_url': 'https://api.dicebear.com/7.x/avataaars/svg?seed=aisha',
        }
      },
      {
        'id': '5',
        'caller_id': 'user6',
        'receiver_id': 'user1',
        'call_type': 'video',
        'status': 'answered',
        'duration_seconds': 560,
        'started_at': DateTime.now().subtract(const Duration(days: 3)),
        'other_user': {
          'full_name': 'Omar Farah',
          'avatar_url': 'https://api.dicebear.com/7.x/avataaars/svg?seed=omar',
        }
      },
      {
        'id': '6',
        'caller_id': 'user1',
        'receiver_id': 'user7',
        'call_type': 'voice',
        'status': 'missed',
        'duration_seconds': 0,
        'started_at': DateTime.now().subtract(const Duration(days: 4)),
        'other_user': {
          'full_name': 'Khadra Abdi',
          'avatar_url':
              'https://api.dicebear.com/7.x/avataaars/svg?seed=khadra',
        }
      },
    ];

    setState(() {
      _calls.clear();
      _calls.addAll(mockCalls);
      _isLoading = false;
      _isRefreshing = false;
    });
  }

  String _formatDuration(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins}:${secs.toString().padLeft(2, '0')}';
  }

  Map<String, dynamic> _getCallStatusInfo(Map<String, dynamic> call) {
    final isOutgoing = call['caller_id'] == _currentUserId;
    final status = call['status'] as String;

    Color color;
    String text;
    IconData icon;

    switch (status) {
      case 'missed':
        color = AppColors.destructiveLight;
        text = isOutgoing ? 'No answer' : 'Missed';
        icon = Iconsax.call;
        break;
      case 'rejected':
        color = AppColors.destructiveLight;
        text = 'Declined';
        icon = Iconsax.call;
        break;
      case 'answered':
      case 'ended':
        color = Theme.of(context).primaryColor;
        text = _formatDuration(call['duration_seconds'] as int);
        icon = isOutgoing ? Iconsax.call_outgoing : Iconsax.call_incoming;
        break;
      default:
        color = Colors.grey;
        text = status;
        icon = Iconsax.call;
    }

    return {'color': color, 'text': text, 'icon': icon};
  }

  void _onCallPressed(Map<String, dynamic> call) {
    final isOutgoing = call['caller_id'] == _currentUserId;
    final otherUserId = isOutgoing ? call['receiver_id'] : call['caller_id'];
    final callType = call['call_type'] as String;

    print('Initiate $callType call with user: $otherUserId');
    // TODO: Implement actual call functionality
  }

  void _onItemPressed(Map<String, dynamic> call) {
    final isOutgoing = call['caller_id'] == _currentUserId;
    final otherUserId = isOutgoing ? call['receiver_id'] : call['caller_id'];

    print('Navigate to chat with user: $otherUserId');
    // TODO: Navigate to chat screen
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: _isLoading
            ? _buildLoadingView()
            : _calls.isEmpty
                ? _buildEmptyView(theme)
                : _buildCallListView(theme),
      ),
    );
  }

  Widget _buildLoadingView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.mutedLight,
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.mutedLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 80,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.mutedLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.mutedLight,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyView(ThemeData theme) {
    return RefreshIndicator(
      onRefresh: _loadCallHistory,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      Iconsax.call,
                      size: 36,
                      color: theme.colorScheme.onSurface.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No call history',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Your voice and video calls will appear here',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCallListView(ThemeData theme) {
    return RefreshIndicator(
      onRefresh: _loadCallHistory,
      displacement: 40,
      backgroundColor: theme.cardColor,
      color: theme.primaryColor,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: _calls.length,
        itemBuilder: (context, index) {
          final call = _calls[index];
          final otherUser = call['other_user'] as Map<String, dynamic>;
          final startedAt = call['started_at'] as DateTime;
          final isOutgoing = call['caller_id'] == _currentUserId;
          final statusInfo = _getCallStatusInfo(call);
          final isVideoCall = call['call_type'] == 'video';

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.dividerTheme.color ?? Colors.transparent,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _onItemPressed(call),
                splashColor: theme.primaryColor.withOpacity(0.1),
                highlightColor: theme.primaryColor.withOpacity(0.05),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Avatar
                      Stack(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(
                                color: theme.dividerTheme.color ??
                                    Colors.grey.shade200,
                                width: 1,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                otherUser['avatar_url'] ?? '',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: theme.primaryColor.withOpacity(0.1),
                                    child: Center(
                                      child: Text(
                                        otherUser['full_name'].substring(0, 1),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: theme.primaryColor,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                      strokeWidth: 2,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          if (isVideoCall)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: theme.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: theme.cardColor,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Iconsax.video,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(width: 14),

                      // Call Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              otherUser['full_name'] ?? 'Unknown User',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  statusInfo['icon'] as IconData,
                                  size: 14,
                                  color: statusInfo['color'] as Color,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  statusInfo['text'] as String,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: statusInfo['color'] as Color,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 3,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(1.5),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    DateFormat('MMM d, h:mm a')
                                        .format(startedAt),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.6),
                                      fontSize: 13,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Call Button
                      IconButton(
                        onPressed: () => _onCallPressed(call),
                        icon: Icon(
                          isVideoCall ? Iconsax.video : Iconsax.call,
                          size: 22,
                          color: theme.primaryColor,
                        ),
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: theme.primaryColor.withOpacity(0.1),
                          padding: const EdgeInsets.all(12),
                          visualDensity: VisualDensity.compact,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 48,
                          minHeight: 48,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// // lib/features/call_history/screens/call_history_screen.dart
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:intl/intl.dart';
// import 'package:xirfadsan_receipt/appbar.dart';
// import 'package:xirfadsan_receipt/core/theme/app_theme.dart';

// class CallHistoryScreen extends StatefulWidget {
//   const CallHistoryScreen({super.key});

//   @override
//   State<CallHistoryScreen> createState() => _CallHistoryScreenState();
// }

// class _CallHistoryScreenState extends State<CallHistoryScreen> {
//   bool _isLoading = true;
//   final List<Map<String, dynamic>> _calls = [];
//   final String _currentUserId = 'user1'; // Replace with actual user ID

//   @override
//   void initState() {
//     super.initState();
//     _loadCallHistory();
//   }

//   Future<void> _loadCallHistory() async {
//     await Future.delayed(const Duration(seconds: 1));

//     final List<Map<String, dynamic>> mockCalls = [
//       {
//         'id': '1',
//         'caller_id': 'user1',
//         'receiver_id': 'user2',
//         'call_type': 'voice',
//         'status': 'answered',
//         'duration_seconds': 240,
//         'started_at': DateTime.now().subtract(const Duration(hours: 2)),
//         'other_user': {
//           'full_name': 'Said-Omar Ahmed',
//           'avatar_url':
//               'https://api.dicebear.com/7.x/avataaars/svg?seed=saidomar',
//         }
//       },
//       {
//         'id': '2',
//         'caller_id': 'user3',
//         'receiver_id': 'user1',
//         'call_type': 'video',
//         'status': 'missed',
//         'duration_seconds': 0,
//         'started_at': DateTime.now().subtract(const Duration(hours: 5)),
//         'other_user': {
//           'full_name': 'Fatima Ali',
//           'avatar_url':
//               'https://api.dicebear.com/7.x/avataaars/svg?seed=fatima',
//         }
//       },
//       {
//         'id': '3',
//         'caller_id': 'user1',
//         'receiver_id': 'user4',
//         'call_type': 'voice',
//         'status': 'ended',
//         'duration_seconds': 180,
//         'started_at': DateTime.now().subtract(const Duration(days: 1)),
//         'other_user': {
//           'full_name': 'Mohamed Hassan',
//           'avatar_url':
//               'https://api.dicebear.com/7.x/avataaars/svg?seed=mohamed',
//         }
//       },
//       {
//         'id': '4',
//         'caller_id': 'user5',
//         'receiver_id': 'user1',
//         'call_type': 'voice',
//         'status': 'rejected',
//         'duration_seconds': 0,
//         'started_at': DateTime.now().subtract(const Duration(days: 2)),
//         'other_user': {
//           'full_name': 'Aisha Mohamed',
//           'avatar_url': 'https://api.dicebear.com/7.x/avataaars/svg?seed=aisha',
//         }
//       },
//       {
//         'id': '5',
//         'caller_id': 'user6',
//         'receiver_id': 'user1',
//         'call_type': 'video',
//         'status': 'answered',
//         'duration_seconds': 560,
//         'started_at': DateTime.now().subtract(const Duration(days: 3)),
//         'other_user': {
//           'full_name': 'Omar Farah',
//           'avatar_url': 'https://api.dicebear.com/7.x/avataaars/svg?seed=omar',
//         }
//       },
//     ];

//     setState(() {
//       _calls.addAll(mockCalls);
//       _isLoading = false;
//     });
//   }

//   String _formatDuration(int seconds) {
//     final mins = seconds ~/ 60;
//     final secs = seconds % 60;
//     return '${mins}:${secs.toString().padLeft(2, '0')}';
//   }

//   Map<String, dynamic> _getCallStatusInfo(Map<String, dynamic> call) {
//     final isOutgoing = call['caller_id'] == _currentUserId;
//     final status = call['status'] as String;

//     Color color;
//     String text;
//     IconData icon;

//     switch (status) {
//       case 'missed':
//         color = AppColors.destructiveLight;
//         text = isOutgoing ? 'No answer' : 'Missed';
//         icon = Iconsax.call;
//         break;
//       case 'rejected':
//         color = AppColors.destructiveLight;
//         text = 'Declined';
//         icon = Iconsax.call;
//         break;
//       case 'answered':
//       case 'ended':
//         color = Theme.of(context).primaryColor;
//         text = _formatDuration(call['duration_seconds'] as int);
//         icon = isOutgoing ? Iconsax.call_outgoing : Iconsax.call_incoming;
//         break;
//       default:
//         color = Colors.grey;
//         text = status;
//         icon = Iconsax.call;
//     }

//     return {'color': color, 'text': text, 'icon': icon};
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     int _selectedIndex = 0;
//     DrawerItem _activeDrawerItem = DrawerItem.dashboard;
//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: CustomAppBar.buildAppBar(context),
//       drawer: CustomAppBar.buildDrawer(context, _activeDrawerItem, (item) {
//         setState(() => _activeDrawerItem = item);
//       }),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Content
//             Expanded(
//               child: _isLoading
//                   ? _buildLoadingView()
//                   : _calls.isEmpty
//                       ? _buildEmptyView(theme)
//                       : _buildCallListView(theme),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingView() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: 5,
//       itemBuilder: (context, index) {
//         return Container(
//           margin: const EdgeInsets.only(bottom: 12),
//           child: Row(
//             children: [
//               Container(
//                 width: 48,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: AppColors.mutedLight,
//                   borderRadius: BorderRadius.circular(24),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       width: 120,
//                       height: 16,
//                       decoration: BoxDecoration(
//                         color: AppColors.mutedLight,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Container(
//                       width: 80,
//                       height: 12,
//                       decoration: BoxDecoration(
//                         color: AppColors.mutedLight,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: AppColors.mutedLight,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildEmptyView(ThemeData theme) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 64,
//               height: 64,
//               decoration: BoxDecoration(
//                 color: theme.colorScheme.secondary.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(32),
//               ),
//               child: Icon(
//                 Iconsax.call,
//                 size: 32,
//                 color: theme.colorScheme.onSurface.withOpacity(0.3),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'No call history',
//               style: theme.textTheme.titleMedium?.copyWith(
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Your voice and video calls will appear here',
//               style: theme.textTheme.bodyMedium?.copyWith(
//                 color: theme.colorScheme.onSurface.withOpacity(0.6),
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCallListView(ThemeData theme) {
//     return RefreshIndicator(
//       onRefresh: _loadCallHistory,
//       child: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: _calls.length,
//         itemBuilder: (context, index) {
//           final call = _calls[index];
//           final otherUser = call['other_user'] as Map<String, dynamic>;
//           final startedAt = call['started_at'] as DateTime;
//           final isOutgoing = call['caller_id'] == _currentUserId;
//           final statusInfo = _getCallStatusInfo(call);

//           return Container(
//             margin: const EdgeInsets.only(bottom: 12),
//             decoration: BoxDecoration(
//               color: theme.cardColor,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 color: theme.dividerTheme.color ?? Colors.transparent,
//                 width: 1,
//               ),
//             ),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(16),
//                 onTap: () {
//                   final otherUserId =
//                       isOutgoing ? call['receiver_id'] : call['caller_id'];
//                   print('Navigate to chat with: $otherUserId');
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Row(
//                     children: [
//                       // Avatar
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(24),
//                         child: Image.network(
//                           otherUser['avatar_url'] ?? '',
//                           width: 48,
//                           height: 48,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               width: 48,
//                               height: 48,
//                               color: theme.primaryColor.withOpacity(0.1),
//                               child: Center(
//                                 child: Text(
//                                   otherUser['full_name'].substring(0, 1),
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.w600,
//                                     color: theme.primaryColor,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Container(
//                               width: 48,
//                               height: 48,
//                               color: AppColors.mutedLight,
//                             );
//                           },
//                         ),
//                       ),

//                       const SizedBox(width: 12),

//                       // Call Info
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     otherUser['full_name'] ?? 'Unknown',
//                                     style:
//                                         theme.textTheme.titleMedium?.copyWith(
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 Icon(
//                                   call['call_type'] == 'video'
//                                       ? Iconsax.video
//                                       : Iconsax.call,
//                                   size: 16,
//                                   color: theme.colorScheme.onSurface
//                                       .withOpacity(0.5),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 6),
//                             Row(
//                               children: [
//                                 // Status Icon
//                                 Icon(
//                                   statusInfo['icon'] as IconData,
//                                   size: 16,
//                                   color: statusInfo['color'] as Color,
//                                 ),
//                                 const SizedBox(width: 6),

//                                 // Status Text
//                                 Text(
//                                   statusInfo['text'] as String,
//                                   style: theme.textTheme.bodyMedium?.copyWith(
//                                     color: statusInfo['color'] as Color,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),

//                                 const SizedBox(width: 12),

//                                 // Separator Dot
//                                 Container(
//                                   width: 4,
//                                   height: 4,
//                                   decoration: BoxDecoration(
//                                     color: theme.colorScheme.onSurface
//                                         .withOpacity(0.3),
//                                     borderRadius: BorderRadius.circular(2),
//                                   ),
//                                 ),

//                                 const SizedBox(width: 12),

//                                 // Time
//                                 Expanded(
//                                   child: Text(
//                                     DateFormat('MMM d, h:mm a')
//                                         .format(startedAt),
//                                     style: theme.textTheme.bodyMedium?.copyWith(
//                                       color: theme.colorScheme.onSurface
//                                           .withOpacity(0.6),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Call Button
//                       IconButton(
//                         onPressed: () {
//                           print('Initiate ${call['call_type']} call');
//                         },
//                         icon: Icon(
//                           call['call_type'] == 'video'
//                               ? Iconsax.video
//                               : Iconsax.call,
//                           size: 20,
//                           color: theme.primaryColor,
//                         ),
//                         style: IconButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           backgroundColor: theme.primaryColor.withOpacity(0.1),
//                           padding: const EdgeInsets.all(12),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
