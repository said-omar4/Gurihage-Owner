// lib/features/privacy/presentation/screens/privacy_policy_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/core/widgets/custom_appbar.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  final List<Map<String, dynamic>> _policies = [
    {
      'id': 'data-collection',
      'icon': Iconsax.document_text,
      'title': 'Information We Collect',
      'content':
          '''We collect information you provide directly to us, including:

• Personal information (name, email, phone number)
• Property details and addresses
• Tenant information you add to manage your properties
• Payment and transaction records
• Communications through the app\'s chat feature
• Device information and usage data

This information is collected when you register, add properties, manage tenants, or use our services.'''
    },
    {
      'id': 'data-use',
      'icon': Iconsax.eye,
      'title': 'How We Use Your Information',
      'content': '''We use the information we collect to:

• Provide, maintain, and improve our services
• Process transactions and send related information
• Send you technical notices, updates, and support messages
• Respond to your comments, questions, and requests
• Monitor and analyze trends, usage, and activities
• Detect, investigate, and prevent fraudulent transactions
• Personalize and improve your experience'''
    },
    {
      'id': 'data-sharing',
      'icon': Iconsax.user_tick,
      'title': 'Information Sharing',
      'content':
          '''We do not sell, trade, or rent your personal information to third parties. We may share your information only in the following circumstances:

• With your consent or at your direction
• With service providers who assist in our operations
• To comply with legal obligations
• To protect our rights, privacy, safety, or property
• In connection with a merger, acquisition, or sale of assets'''
    },
    {
      'id': 'data-security',
      'icon': Iconsax.lock_1,
      'title': 'Data Security',
      'content':
          '''We implement appropriate technical and organizational measures to protect your personal information, including:

• Encryption of data in transit and at rest
• Regular security assessments and audits
• Access controls and authentication mechanisms
• Secure data storage with regular backups
• Employee training on data protection

While we strive to protect your information, no method of transmission or storage is 100% secure.'''
    },
    {
      'id': 'notifications',
      'icon': Iconsax.notification_bing,
      'title': 'Notifications & Communications',
      'content': '''We may send you notifications about:

• Property-related updates and reminders
• Payment confirmations and receipts
• Booking requests and confirmations
• Important account security alerts
• App updates and new features

You can manage your notification preferences in the app settings at any time.'''
    },
    {
      'id': 'data-retention',
      'icon': Iconsax.trash,
      'title': 'Data Retention & Deletion',
      'content':
          '''We retain your personal information for as long as necessary to provide our services and fulfill the purposes described in this policy. You have the right to:

• Access your personal data
• Correct inaccurate information
• Request deletion of your data
• Export your data in a portable format
• Opt-out of marketing communications

To exercise these rights, please contact our support team.'''
    },
    {
      'id': 'contact',
      'icon': Iconsax.sms,
      'title': 'Contact Us',
      'content':
          '''If you have any questions about this Privacy Policy or our data practices, please contact us at:

Email: privacy@gurihage.com
Phone: +252 61 XXX XXXX
Address: Mogadishu, Somalia

We will respond to your inquiry within 30 days.'''
    }
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        title: 'Privacy Policy',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Introduction Card
              _buildIntroductionCard(theme),
              const SizedBox(height: 24),

              // Policy Sections (Accordion)
              _buildPolicyAccordion(theme),
              const SizedBox(height: 16),

              // Agreement Note
              _buildAgreementNote(theme),
              const SizedBox(height: 24),

              // Footer
              _buildFooter(theme),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ========== INTRODUCTION CARD ==========
  Widget _buildIntroductionCard(ThemeData theme) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shield Icon & Title
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Iconsax.shield_tick,
                  size: 24,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Privacy Matters',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Last updated: January 2024',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            'At Gurihage, we are committed to protecting your privacy and ensuring the security '
            'of your personal information. This Privacy Policy explains how we collect, use, '
            'disclose, and safeguard your information when you use our mobile application.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ========== POLICY ACCORDION ==========
  Widget _buildPolicyAccordion(ThemeData theme) {
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
        children: [
          // Policy Items
          ..._policies.map((policy) {
            return _buildPolicyItem(theme, policy);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPolicyItem(ThemeData theme, Map<String, dynamic> policy) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: theme.dividerTheme.color ?? Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(vertical: 8),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            policy['icon'] as IconData,
            size: 18,
            color: theme.primaryColor,
          ),
        ),
        title: Text(
          policy['title'] as String,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
              top: 8,
            ),
            child: Text(
              policy['content'] as String,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
        iconColor: theme.primaryColor,
        collapsedIconColor: theme.colorScheme.onSurface.withOpacity(0.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        childrenPadding: EdgeInsets.zero,
        maintainState: true,
      ),
    );
  }

  // ========== AGREEMENT NOTE ==========
  Widget _buildAgreementNote(ThemeData theme) {
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
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            'By using Gurihage, you agree to the collection and use of information '
            'in accordance with this Privacy Policy.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              fontSize: 14,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  // ========== FOOTER ==========
  Widget _buildFooter(ThemeData theme) {
    return Text(
      '© 2024 Gurihage. All rights reserved.',
      style: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(0.4),
        fontSize: 12,
      ),
    );
  }
}

// ========== USAGE ==========
/*
// With Custom AppBar:
Scaffold(
  appBar: CustomAppBar(
    title: 'Privacy Policy',
    showBackButton: true,
  ),
  body: const PrivacyPolicyScreen(),
);

// Direct Navigation:
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const PrivacyPolicyScreen(),
  ),
);
*/
