// lib/features/settings/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/appbar.dart';
import 'package:xirfadsan_receipt/core/theme/app_theme.dart';
import 'package:xirfadsan_receipt/features/App%20Setting/about_app.dart';
import 'package:xirfadsan_receipt/features/App%20Setting/contact_us.dart';
import 'package:xirfadsan_receipt/features/App%20Setting/privacy_policy.dart';
import 'package:xirfadsan_receipt/features/App%20Setting/terms_of_service.dart';
import 'package:xirfadsan_receipt/features/profile/presentation/screens/help_support.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  String _selectedLanguage = 'en';
  final String _appVersion = '1.0.0';
  final String _appName = 'Gurihage Owner App';

  // Check if user is admin (replace with your actual auth logic)
  bool _isAdmin = false; // Set this based on user role

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'so', 'name': 'Soomaali'},
    {'code': 'ar', 'name': 'العربية'},
  ];

  final List<Map<String, dynamic>> _aboutSupportItems = [
    {
      'icon': Iconsax.info_circle,
      'title': 'About App',
      'route': '/about',
    },
    {
      'icon': Iconsax.message_question,
      'title': 'Help & Support',
      'route': '/help-support',
    },
    {
      'icon': Iconsax.sms,
      'title': 'Contact Us',
      'route': '/contact',
    },
    {
      'icon': Iconsax.shield_tick,
      'title': 'Privacy Policy',
      'route': '/privacy-policy',
    },
    {
      'icon': Iconsax.document_text,
      'title': 'Terms of Service',
      'route': '/terms',
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  // Check user role (replace with your actual auth logic)
  void _checkUserRole() {
    // Example: Get user role from your auth provider
    // final user = AuthProvider.of(context).user;
    // setState(() => _isAdmin = user?.role == 'admin');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Admin Panel Section (only for admins)
              if (_isAdmin) ...[
                _buildSectionTitle('ADMIN'),
                const SizedBox(height: 8),
                _buildAdminCard(theme),
                const SizedBox(height: 24),
              ],

              // Appearance Section
              _buildSectionTitle('APPEARANCE'),
              const SizedBox(height: 8),
              _buildAppearanceCard(theme),
              const SizedBox(height: 24),

              // Language & Region Section
              _buildSectionTitle('LANGUAGE & REGION'),
              const SizedBox(height: 8),
              _buildLanguageCard(theme),
              const SizedBox(height: 24),

              // Notifications Section
              _buildSectionTitle('NOTIFICATIONS'),
              const SizedBox(height: 8),
              _buildNotificationCard(theme),
              const SizedBox(height: 24),

              // About & Support Section
              _buildSectionTitle('ABOUT & SUPPORT'),
              const SizedBox(height: 8),
              _buildAboutSupportCard(theme),
              const SizedBox(height: 32),

              // App Version
              _buildAppVersion(),
            ],
          ),
        ),
      ),
    );
  }

  // ========== ADMIN CARD ==========
  Widget _buildAdminCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerTheme.color ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            print('Navigate to admin panel');
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (_) => AdminPanelScreen(),
            // ));
          },
          splashColor: theme.primaryColor.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Iconsax.shield_tick,
                    size: 20,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),

                // Title
                Expanded(
                  child: Text(
                    'Admin Panel',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Arrow Icon
                Icon(
                  Iconsax.arrow_right_3,
                  size: 18,
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== APPEARANCE CARD ==========
  Widget _buildAppearanceCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerTheme.color ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => setState(() => _darkMode = !_darkMode),
          splashColor: theme.primaryColor.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _darkMode ? Iconsax.moon : Iconsax.sun_1,
                    size: 20,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(width: 12),

                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dark Mode',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Toggle dark theme',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Switch
                Transform.scale(
                  scale: 0.8,
                  child: Switch.adaptive(
                    value: _darkMode,
                    onChanged: (value) {
                      setState(() => _darkMode = value);
                      // TODO: Implement theme change
                      // ThemeProvider.of(context).toggleTheme();
                      print('Dark mode: $value');
                    },
                    activeColor: theme.primaryColor,
                    activeTrackColor: theme.primaryColor.withOpacity(0.5),
                    inactiveTrackColor:
                        theme.colorScheme.onSurface.withOpacity(0.2),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== LANGUAGE CARD ==========
  Widget _buildLanguageCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerTheme.color ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Language Header
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.global,
                    size: 20,
                    color: AppColors.primaryLight,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Language',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Select your preferred language',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Language Dropdown
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.dividerTheme.color ?? Colors.grey.shade200,
                  width: 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: _showLanguageDialog,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _getLanguageName(_selectedLanguage),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Icon(
                          Iconsax.arrow_down_1,
                          size: 18,
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== NOTIFICATION CARD ==========
  Widget _buildNotificationCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerTheme.color ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            print('Navigate to notification settings');
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (_) => NotificationSettingsScreen(),
            // ));
          },
          splashColor: theme.primaryColor.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.notification,
                    size: 20,
                    color: AppColors.primaryLight,
                  ),
                ),
                const SizedBox(width: 12),

                // Title
                Expanded(
                  child: Text(
                    'Notification Settings',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Arrow Icon
                Icon(
                  Iconsax.arrow_right_3,
                  size: 18,
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== ABOUT & SUPPORT CARD ==========
  Widget _buildAboutSupportCard(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerTheme.color ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        children: List.generate(_aboutSupportItems.length, (index) {
          final item = _aboutSupportItems[index];
          final isLast = index == _aboutSupportItems.length - 1;

          return Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                    index == 0 ? 16 : 0,
                  ),
                  onTap: () => _navigateToScreen(item['route'] as String),
                  splashColor: theme.primaryColor.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            size: 18,
                            color: theme.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item['title'] as String,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Iconsax.arrow_right_3,
                          size: 18,
                          color: theme.colorScheme.onSurface.withOpacity(0.3),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Divider (except for last item)
              if (!isLast)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    height: 0,
                    thickness: 1,
                    color: theme.dividerTheme.color,
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  // ========== HELPER METHODS ==========

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            letterSpacing: 0.5,
            fontSize: 11,
          ),
    );
  }

  // App Version Widget
  Widget _buildAppVersion() {
    return Center(
      child: Column(
        children: [
          Text(
            _appName,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 14,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Version $_appVersion',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  fontSize: 13,
                ),
          ),
        ],
      ),
    );
  }

  String _getLanguageName(String code) {
    final language = _languages.firstWhere(
      (lang) => lang['code'] == code,
      orElse: () => {'code': 'en', 'name': 'English'},
    );
    return language['name']!;
  }

  void _showLanguageDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Title
              Text(
                'Select Language',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
              ),
              const SizedBox(height: 16),

              // Language Options
              ..._languages.map((language) {
                final isSelected = language['code'] == _selectedLanguage;

                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      setState(() => _selectedLanguage = language['code']!);
                      Navigator.pop(context);
                      _changeLanguage(language['code']!);
                    },
                    splashColor:
                        Theme.of(context).primaryColor.withOpacity(0.1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            language['name']!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).colorScheme.onSurface,
                                ),
                          ),
                          const Spacer(),
                          if (isSelected)
                            Icon(
                              Iconsax.tick_circle,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

              const SizedBox(height: 24),

              // Cancel Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                    side: BorderSide(
                      color: Theme.of(context).dividerTheme.color ??
                          Colors.grey.shade300,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _changeLanguage(String languageCode) {
    // TODO: Implement language change logic
    // For example:
    // 1. Save language preference to shared preferences
    // 2. Rebuild app with new locale
    // 3. Handle RTL for Arabic

    print('Language changed to: $languageCode');

    // For Arabic RTL support:
    if (languageCode == 'ar') {
      // Set RTL direction
      // You might need to restart the app or use a state management solution
    }
  }

  void _navigateToScreen(String route) {
    switch (route) {
      case '/about':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AboutAppScreen(),
          ),
        );
        break;
      case '/help-support':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HelpSupportScreen(),
          ),
        );
        break;
      case '/contact':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ContactUsScreen(),
          ),
        );
        break;
      case '/privacy-policy':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PrivacyPolicyScreen(),
          ),
        );
        break;
      case '/terms':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TermsOfServiceScreen(),
          ),
        );
        break;
      default:
        print('Unknown route: $route');
    }
  }
}

// // lib/features/settings/screens/settings_screen.dart

// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:xirfadsan_receipt/appbar.dart';
// import 'package:xirfadsan_receipt/core/theme/app_theme.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   bool _darkMode = false;
//   String _selectedLanguage = 'en';
//   final String _appVersion = '1.0.0';
//   final String _appName = 'Gurihage Owner App';

//   final List<Map<String, String>> _languages = [
//     {'code': 'en', 'name': 'English'},
//     {'code': 'so', 'name': 'Somali'},
//     {'code': 'ar', 'name': 'Arabic'},
//   ];

//   final List<Map<String, dynamic>> _aboutSupportItems = [
//     {
//       'icon': Iconsax.info_circle,
//       'title': 'About App',
//       'onTap': () => print('About App tapped'),
//     },
//     {
//       'icon': Iconsax.message_question,
//       'title': 'Help & Support',
//       'onTap': () => print('Help & Support tapped'),
//     },
//     {
//       'icon': Iconsax.shield_tick,
//       'title': 'Privacy Policy',
//       'onTap': () => print('Privacy Policy tapped'),
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = theme.brightness == Brightness.dark;

//     int _selectedIndex = 0;
//     DrawerItem _activeDrawerItem = DrawerItem.dashboard;

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: CustomAppBar.buildAppBar(context),
//       drawer: CustomAppBar.buildDrawer(context, _activeDrawerItem, (item) {
//         setState(() => _activeDrawerItem = item);
//       }),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 8),

//               // Appearance Section
//               _buildSectionTitle('Appearance'),
//               const SizedBox(height: 8),

//               _buildAppearanceCard(theme, isDark),
//               const SizedBox(height: 24),

//               // Language & Region Section
//               _buildSectionTitle('Language & Region'),
//               const SizedBox(height: 8),

//               _buildLanguageCard(theme),
//               const SizedBox(height: 24),

//               // Notifications Section
//               _buildSectionTitle('Notifications'),
//               const SizedBox(height: 8),

//               _buildNotificationCard(theme),
//               const SizedBox(height: 24),

//               // About & Support Section
//               _buildSectionTitle('About & Support'),
//               const SizedBox(height: 8),

//               _buildAboutSupportCard(theme),
//               const SizedBox(height: 32),

//               // App Version
//               _buildAppVersion(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Section Title Widget
//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title.toUpperCase(),
//       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//             fontWeight: FontWeight.w600,
//             color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
//             letterSpacing: 0.5,
//             fontSize: 12,
//           ),
//     );
//   }

//   // Appearance Card Widget
//   Widget _buildAppearanceCard(ThemeData theme, bool isDark) {
//     return Container(
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: theme.dividerTheme.color ?? Colors.transparent,
//           width: 1,
//         ),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: () => setState(() => _darkMode = !_darkMode),
//           splashColor: theme.primaryColor.withOpacity(0.1),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 // Icon
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: theme.primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     _darkMode ? Iconsax.moon : Iconsax.sun_1,
//                     size: 20,
//                     color: theme.primaryColor,
//                   ),
//                 ),
//                 const SizedBox(width: 12),

//                 // Title & Subtitle
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Dark Mode',
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         'Toggle dark theme',
//                         style: theme.textTheme.bodyMedium?.copyWith(
//                           color: theme.colorScheme.onSurface.withOpacity(0.6),
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 12),

//                 // Switch
//                 Transform.scale(
//                   scale: 0.8,
//                   child: Switch.adaptive(
//                     value: _darkMode,
//                     onChanged: (value) {
//                       setState(() => _darkMode = value);
//                       // TODO: Implement theme change
//                       print('Dark mode: $value');
//                     },
//                     activeColor: theme.primaryColor,
//                     activeTrackColor: theme.primaryColor.withOpacity(0.5),
//                     inactiveTrackColor:
//                         theme.colorScheme.onSurface.withOpacity(0.2),
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Language Card Widget
//   Widget _buildLanguageCard(ThemeData theme) {
//     return Container(
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: theme.dividerTheme.color ?? Colors.transparent,
//           width: 1,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Language Header
//             Row(
//               children: [
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: theme.primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Iconsax.global,
//                     size: 20,
//                     color: AppColors.primaryLight,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Language',
//                         style: theme.textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         'Select your preferred language',
//                         style: theme.textTheme.bodyMedium?.copyWith(
//                           color: theme.colorScheme.onSurface.withOpacity(0.6),
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),

//             // Language Dropdown
//             Container(
//               decoration: BoxDecoration(
//                 color: theme.colorScheme.surface,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: theme.dividerTheme.color ?? Colors.grey.shade200,
//                   width: 1,
//                 ),
//               ),
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(12),
//                   onTap: _showLanguageDialog,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 14,
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             _getLanguageName(_selectedLanguage),
//                             style: theme.textTheme.bodyMedium?.copyWith(
//                               fontSize: 15,
//                             ),
//                           ),
//                         ),
//                         Icon(
//                           Iconsax.arrow_down_1,
//                           size: 18,
//                           color: theme.colorScheme.onSurface.withOpacity(0.5),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Notification Card Widget
//   Widget _buildNotificationCard(ThemeData theme) {
//     return Container(
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: theme.dividerTheme.color ?? Colors.transparent,
//           width: 1,
//         ),
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(16),
//           onTap: () {
//             print('Navigate to notification settings');
//             // Navigator.push(context, MaterialPageRoute(
//             //   builder: (_) => NotificationSettingsScreen(),
//             // ));
//           },
//           splashColor: theme.primaryColor.withOpacity(0.1),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 // Icon
//                 Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: theme.primaryColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Iconsax.notification,
//                     size: 20,
//                     color: AppColors.primaryLight,
//                   ),
//                 ),
//                 const SizedBox(width: 12),

//                 // Title
//                 Expanded(
//                   child: Text(
//                     'Notification Settings',
//                     style: theme.textTheme.titleMedium?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),

//                 // Arrow Icon
//                 Icon(
//                   Iconsax.arrow_right_3,
//                   size: 18,
//                   color: theme.colorScheme.onSurface.withOpacity(0.5),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // About & Support Card Widget
//   Widget _buildAboutSupportCard(ThemeData theme) {
//     return Container(
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: theme.dividerTheme.color ?? Colors.transparent,
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: List.generate(_aboutSupportItems.length, (index) {
//           final item = _aboutSupportItems[index];
//           final isLast = index == _aboutSupportItems.length - 1;

//           return Column(
//             children: [
//               Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(
//                     index == 0 ? 16 : 0,
//                   ),
//                   onTap: item['onTap'] as Function(),
//                   splashColor: theme.primaryColor.withOpacity(0.1),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 16,
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 36,
//                           height: 36,
//                           decoration: BoxDecoration(
//                             color: theme.primaryColor.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Icon(
//                             item['icon'] as IconData,
//                             size: 18,
//                             color: theme.primaryColor,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Text(
//                             item['title'] as String,
//                             style: theme.textTheme.titleMedium?.copyWith(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               // Divider (except for last item)
//               if (!isLast)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Divider(
//                     height: 0,
//                     thickness: 1,
//                     color: theme.dividerTheme.color,
//                   ),
//                 ),
//             ],
//           );
//         }),
//       ),
//     );
//   }

//   // App Version Widget
//   Widget _buildAppVersion() {
//     return Center(
//       child: Column(
//         children: [
//           Text(
//             _appName,
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   color:
//                       Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
//                   fontSize: 14,
//                 ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'Version $_appVersion',
//             style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                   color:
//                       Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
//                   fontSize: 13,
//                 ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper Methods
//   String _getLanguageName(String code) {
//     final language = _languages.firstWhere(
//       (lang) => lang['code'] == code,
//       orElse: () => {'code': 'en', 'name': 'English'},
//     );
//     return language['name']!;
//   }

//   void _showLanguageDialog() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Theme.of(context).cardColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(24),
//         ),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Handle
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color:
//                       Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Title
//               Text(
//                 'Select Language',
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18,
//                     ),
//               ),
//               const SizedBox(height: 16),

//               // Language Options
//               ..._languages.map((language) {
//                 final isSelected = language['code'] == _selectedLanguage;

//                 return Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(12),
//                     onTap: () {
//                       setState(() => _selectedLanguage = language['code']!);
//                       Navigator.pop(context);
//                       print('Language changed to: ${language['name']}');
//                     },
//                     splashColor:
//                         Theme.of(context).primaryColor.withOpacity(0.1),
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 14,
//                       ),
//                       decoration: BoxDecoration(
//                         color: isSelected
//                             ? Theme.of(context).primaryColor.withOpacity(0.1)
//                             : Colors.transparent,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: isSelected
//                               ? Theme.of(context).primaryColor
//                               : Colors.transparent,
//                           width: 1,
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             language['name']!,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyLarge
//                                 ?.copyWith(
//                                   fontWeight: isSelected
//                                       ? FontWeight.w600
//                                       : FontWeight.w400,
//                                   color: isSelected
//                                       ? Theme.of(context).primaryColor
//                                       : Theme.of(context).colorScheme.onSurface,
//                                 ),
//                           ),
//                           const Spacer(),
//                           if (isSelected)
//                             Icon(
//                               Iconsax.tick_circle,
//                               size: 20,
//                               color: Theme.of(context).primaryColor,
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),

//               const SizedBox(height: 24),

//               // Cancel Button
//               SizedBox(
//                 width: double.infinity,
//                 child: OutlinedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     side: BorderSide(
//                       color: Theme.of(context).dividerTheme.color ??
//                           Colors.grey.shade300,
//                     ),
//                   ),
//                   child: Text(
//                     'Cancel',
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                           fontWeight: FontWeight.w500,
//                         ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 8),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
