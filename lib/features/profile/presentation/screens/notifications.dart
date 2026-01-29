// lib/features/notifications/presentation/screens/notifications_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Sample notifications data (replace with your actual data)
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'type': 'payment',
      'title': 'Payment Received',
      'message': 'Your payment of \$1,200 for January rent has been confirmed.',
      'read': false,
      'created_at': DateTime.now().subtract(const Duration(minutes: 5)),
    },
    {
      'id': '2',
      'type': 'booking',
      'title': 'New Booking Request',
      'message': 'John Doe wants to book your apartment from Feb 1-15, 2024.',
      'read': false,
      'created_at': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'id': '3',
      'type': 'message',
      'title': 'New Message',
      'message': 'You have a new message from tenant Sarah Johnson.',
      'read': true,
      'created_at': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': '4',
      'type': 'complaint',
      'title': 'Complaint Submitted',
      'message': 'A new complaint has been submitted for Apartment 304.',
      'read': true,
      'created_at': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': '5',
      'type': 'payment',
      'title': 'Payment Reminder',
      'message': 'Reminder: Rent payment for February is due in 3 days.',
      'read': true,
      'created_at': DateTime.now().subtract(const Duration(days: 3)),
    },
  ];

  int get _unreadCount {
    return _notifications.where((n) => n['read'] == false).length;
  }

  String _getNotificationIcon(String type) {
    switch (type) {
      case 'payment':
        return '💰';
      case 'booking':
        return '📅';
      case 'complaint':
        return '⚠️';
      case 'message':
        return '💬';
      default:
        return '🔔';
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'payment':
        return Colors.green;
      case 'booking':
        return Colors.blue;
      case 'complaint':
        return Colors.orange;
      case 'message':
        return Colors.purple;
      default:
        return const Color(0xFF22C55E);
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  void _markAsRead(String id) {
    setState(() {
      final index = _notifications.indexWhere((n) => n['id'] == id);
      if (index != -1) {
        _notifications[index]['read'] = true;
      }
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        if (notification['read'] == false) {
          notification['read'] = true;
        }
      }
    });
  }

  void _deleteNotification(String id) {
    setState(() {
      _notifications.removeWhere((n) => n['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      if (_unreadCount > 0) ...[
                        const SizedBox(height: 2),
                        Text(
                          '$_unreadCount unread',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Spacer(),
                  if (_unreadCount > 0)
                    ElevatedButton(
                      onPressed: _markAllAsRead,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF22C55E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Color(0xFF22C55E),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.check_circle,
                              size:
                                  14), // FIXED: Changed from Iconsax.tick_circle
                          SizedBox(width: 4),
                          Text(
                            'Mark all read',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // Notifications List
            Expanded(
              child: _notifications.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _notifications.length,
                      itemBuilder: (context, index) {
                        final notification = _notifications[index];
                        final isRead = notification['read'] as bool;
                        final type = notification['type'] as String;
                        final title = notification['title'] as String;
                        final message = notification['message'] as String;
                        final dateTime = notification['created_at'] as DateTime;
                        final id = notification['id'] as String;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isRead
                                  ? const Color(0xFFE2E8F0)
                                  : const Color(0xFF22C55E).withOpacity(0.3),
                              width: isRead ? 1 : 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Icon
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _getNotificationColor(type)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _getNotificationIcon(type),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Content
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title and Type
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        title,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: isRead
                                                              ? Colors.black87
                                                              : const Color(
                                                                  0xFF22C55E),
                                                        ),
                                                      ),
                                                    ),
                                                    if (!isRead)
                                                      Container(
                                                        width: 8,
                                                        height: 8,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0xFF22C55E),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  message,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey.shade700,
                                                    height: 1.4,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getNotificationColor(type)
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color:
                                                    _getNotificationColor(type)
                                                        .withOpacity(0.3),
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              type.toUpperCase(),
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    _getNotificationColor(type),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 12),

                                      // Date and Actions
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _formatDateTime(dateTime),
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              if (!isRead)
                                                GestureDetector(
                                                  onTap: () => _markAsRead(id),
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                              0xFF22C55E)
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .check_circle, // FIXED: Changed from Iconsax.tick_circle
                                                          size: 12,
                                                          color:
                                                              Color(0xFF22C55E),
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          'Mark read',
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            color: const Color(
                                                                0xFF22C55E),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              const SizedBox(width: 8),
                                              GestureDetector(
                                                onTap: () =>
                                                    _deleteNotification(id),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                  ),
                                                  child: Icon(
                                                    Iconsax
                                                        .trash, // This one is correct in Iconsax
                                                    size: 14,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Iconsax.notification, // This one is correct in Iconsax
              size: 40,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'You\'re all caught up! Check back later.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
