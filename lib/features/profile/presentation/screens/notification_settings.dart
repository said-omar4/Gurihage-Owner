// lib/features/profile/presentation/screens/notification_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  // Notification settings state
  bool _isLoading = false;
  bool _isSaving = false;

  Map<String, bool> _settings = {
    'push_enabled': true,
    'booking_alerts': true,
    'complaint_alerts': true,
    'payment_alerts': true,
    'message_alerts': true,
    'call_alerts': true,
    'sound_enabled': true,
    'vibration_enabled': true,
  };

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() => _isLoading = true);

    // TODO: Replace with your actual data fetching
    // Example with Supabase:
    // final supabase = Supabase.instance.client;
    // final { data, error } = await supabase
    //     .from('notification_settings')
    //     .select()
    //     .eq('user_id', userId)
    //     .single();

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() => _isLoading = false);
  }

  Future<void> _updateSetting(String key, bool value) async {
    // Update local state immediately for better UX
    setState(() => _settings[key] = value);

    setState(() => _isSaving = true);

    try {
      // TODO: Replace with your actual save logic
      // Example with Supabase:
      // final supabase = Supabase.instance.client;
      // final { error } = await supabase
      //     .from('notification_settings')
      //     .upsert({
      //       'user_id': userId,
      //       ..._settings,
      //       'updated_at': DateTime.now().toIso8601String(),
      //     });
      // if (error) throw error;

      await Future.delayed(const Duration(milliseconds: 300));

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notification settings updated'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      // Revert on error
      setState(() => _settings[key] = !value);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save: $error'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String label,
    required String description,
    required String settingKey,
    bool disabled = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          // Icon
          Icon(
            icon,
            size: 22,
            color: const Color(0xFF22C55E),
          ),
          const SizedBox(width: 12),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Switch
          Switch(
            value: _settings[settingKey] ?? false,
            onChanged: (_isSaving ||
                        disabled ||
                        !(_settings['push_enabled'] ?? true)) &&
                    settingKey != 'push_enabled'
                ? null
                : (value) => _updateSetting(settingKey, value),
            activeColor: const Color(0xFF22C55E),
            inactiveTrackColor: Colors.grey.shade300,
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
                  const Text(
                    'Notification Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Loading state
            if (_isLoading)
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Master Toggle Card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Row(
                                children: [
                                  const Icon(
                                    Iconsax.notification,
                                    size: 20,
                                    color: Color(0xFF22C55E),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Push Notifications',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Master Switch
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Enable Push Notifications',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Receive notifications on your device',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Switch(
                                    value: _settings['push_enabled'] ?? false,
                                    onChanged: _isSaving
                                        ? null
                                        : (value) => _updateSetting(
                                            'push_enabled', value),
                                    activeColor: const Color(0xFF22C55E),
                                    inactiveTrackColor: Colors.grey.shade300,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Alert Types Card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              const Text(
                                'Alert Types',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Setting Items
                              _buildSettingItem(
                                icon: Iconsax.calendar,
                                label: 'Booking Alerts',
                                description: 'New booking requests and updates',
                                settingKey: 'booking_alerts',
                                disabled: !(_settings['push_enabled'] ?? true),
                              ),
                              const Divider(
                                  height: 1, color: Color(0xFFF1F5F9)),
                              _buildSettingItem(
                                icon: Iconsax.warning_2,
                                label: 'Complaint Alerts',
                                description: 'New complaints and responses',
                                settingKey: 'complaint_alerts',
                                disabled: !(_settings['push_enabled'] ?? true),
                              ),
                              const Divider(
                                  height: 1, color: Color(0xFFF1F5F9)),
                              _buildSettingItem(
                                icon: Iconsax.card,
                                label: 'Payment Alerts',
                                description:
                                    'Payment confirmations and reminders',
                                settingKey: 'payment_alerts',
                                disabled: !(_settings['push_enabled'] ?? true),
                              ),
                              const Divider(
                                  height: 1, color: Color(0xFFF1F5F9)),
                              _buildSettingItem(
                                icon: Iconsax.message,
                                label: 'Message Alerts',
                                description: 'New chat messages from tenants',
                                settingKey: 'message_alerts',
                                disabled: !(_settings['push_enabled'] ?? true),
                              ),
                              const Divider(
                                  height: 1, color: Color(0xFFF1F5F9)),
                              _buildSettingItem(
                                icon: Iconsax.call,
                                label: 'Call Alerts',
                                description: 'Incoming voice and video calls',
                                settingKey: 'call_alerts',
                                disabled: !(_settings['push_enabled'] ?? true),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Sound & Vibration Card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFE2E8F0),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              const Text(
                                'Sound & Vibration',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Setting Items
                              _buildSettingItem(
                                icon: Iconsax.volume_high,
                                label: 'Sound',
                                description: 'Play sound for notifications',
                                settingKey: 'sound_enabled',
                                disabled: !(_settings['push_enabled'] ?? true),
                              ),
                              const Divider(
                                  height: 1, color: Color(0xFFF1F5F9)),
                              _buildSettingItem(
                                icon: Iconsax.call, //vibration
                                label: 'Vibration',
                                description: 'Vibrate for notifications',
                                settingKey: 'vibration_enabled',
                                disabled: !(_settings['push_enabled'] ?? true),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Info Text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'You may also need to enable notifications in your browser or device settings for push notifications to work.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
