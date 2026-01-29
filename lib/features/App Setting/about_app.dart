// lib/features/about/presentation/screens/about_app_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/core/widgets/custom_appbar.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  final List<String> _features = const [
    "Property Management",
    "Tenant Management",
    "Payment Tracking",
    "Real-time Chat",
    "Booking Management",
    "Analytics & Reports",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        title: 'About Application',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 8),

                // App Logo & Info
                _buildAppLogoSection(theme),
                const SizedBox(height: 24),

                // About Description
                _buildAboutCard(theme),
                const SizedBox(height: 16),

                // Key Features
                _buildFeaturesCard(theme),
                const SizedBox(height: 16),

                // Contact Information
                _buildContactCard(theme),
                const SizedBox(height: 16),

                // Developer Info
                _buildDeveloperCard(theme),
                const SizedBox(height: 24),

                // Footer
                _buildFooter(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== APP LOGO SECTION ==========
  Widget _buildAppLogoSection(ThemeData theme) {
    return Column(
      children: [
        // Logo Container
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Icon(
              Iconsax.home_2,
              size: 60,
              color: theme.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // App Name
        Text(
          'Gurihage',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 4),

        // Tagline
        Text(
          'Property Management Made Easy',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.6),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),

        // Version Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Version 1.0.0',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  // ========== ABOUT CARD ==========
  Widget _buildAboutCard(ThemeData theme) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Gurihage',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Gurihage is a comprehensive property management application '
              'designed specifically for property owners in Somalia. '
              'Our mission is to simplify property management by providing '
              'powerful tools for managing properties, tenants, payments, '
              'and communications all in one place.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== FEATURES CARD ==========
  Widget _buildFeaturesCard(ThemeData theme) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key Features',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),

            // Features Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.5,
              ),
              itemCount: _features.length,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _features[index],
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                          fontSize: 13,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ========== CONTACT CARD ==========
  Widget _buildContactCard(ThemeData theme) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Email
            _buildContactItem(
              theme: theme,
              icon: Iconsax.sms,
              title: 'Email',
              subtitle: 'support@gurihage.com',
            ),
            const SizedBox(height: 16),

            // Divider
            Divider(color: theme.dividerTheme.color),
            const SizedBox(height: 16),

            // Phone
            _buildContactItem(
              theme: theme,
              icon: Iconsax.call,
              title: 'Phone',
              subtitle: '+252 61 XXX XXXX',
            ),
            const SizedBox(height: 16),

            // Divider
            Divider(color: theme.dividerTheme.color),
            const SizedBox(height: 16),

            // Website
            _buildContactItem(
              theme: theme,
              icon: Iconsax.global,
              title: 'Website',
              subtitle: 'www.gurihage.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            size: 20,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ========== DEVELOPER CARD ==========
  Widget _buildDeveloperCard(ThemeData theme) {
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
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Iconsax.buildings_2,
                size: 20,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Developed by',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Gurihage Technologies',
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
      ),
    );
  }

  // ========== FOOTER ==========
  Widget _buildFooter(ThemeData theme) {
    return Column(
      children: [
        // Made with love
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Made with ',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontSize: 13,
              ),
            ),
            const Icon(
              Iconsax.heart,
              size: 14,
              color: Colors.red,
            ),
            Text(
              ' in Somalia',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Copyright
        Text(
          '© 2024 Gurihage. All rights reserved.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.4),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
