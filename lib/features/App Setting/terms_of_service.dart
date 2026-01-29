// lib/features/terms/presentation/screens/terms_of_service_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/core/widgets/custom_appbar.dart';

class TermsOfServiceScreen extends StatefulWidget {
  const TermsOfServiceScreen({super.key});

  @override
  State<TermsOfServiceScreen> createState() => _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  final List<Map<String, dynamic>> _terms = [
    {
      'id': 'acceptance',
      'icon': Iconsax.document_text,
      'title': 'Acceptance of Terms',
      'content':
          '''By downloading, installing, or using the Gurihage application, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use the application.

These terms apply to all users of the app, including property owners, managers, and any other individuals who access or use the service.'''
    },
    {
      'id': 'user-accounts',
      'icon': Iconsax.profile_2user,
      'title': 'User Accounts',
      'content':
          '''To use certain features of Gurihage, you must create an account. You agree to:

• Provide accurate and complete information
• Maintain the security of your account credentials
• Notify us immediately of any unauthorized access
• Accept responsibility for all activities under your account
• Not share your account with others

We reserve the right to suspend or terminate accounts that violate these terms.'''
    },
    {
      'id': 'services',
      'icon': Iconsax.refresh_circle,
      'title': 'Use of Services',
      'content': '''Gurihage provides property management tools including:

• Property listing and management
• Tenant information management
• Payment tracking and receipts
• Communication features
• Booking management

You agree to use these services only for lawful purposes and in accordance with these terms. You may not use the service to:

• Violate any applicable laws or regulations
• Infringe on the rights of others
• Distribute malware or harmful content
• Attempt to gain unauthorized access'''
    },
    {
      'id': 'payments',
      'icon': Iconsax.card,
      'title': 'Payments & Fees',
      'content':
          '''Certain features of Gurihage may require payment. By using paid features, you agree to:

• Pay all applicable fees and charges
• Provide accurate billing information
• Authorize us to charge your payment method
• Accept that fees are non-refundable unless otherwise stated

We reserve the right to modify our pricing with reasonable notice to users.'''
    },
    {
      'id': 'content',
      'icon': Iconsax.document_text,
      'title': 'User Content',
      'content':
          '''You retain ownership of content you submit to Gurihage. By submitting content, you grant us a license to:

• Store and display your content
• Use content to provide and improve our services
• Create backups for data protection

You are responsible for ensuring you have the right to share any content you submit, including property images and tenant information.'''
    },
    {
      'id': 'liability',
      'icon': Iconsax.warning_2,
      'title': 'Limitation of Liability',
      'content':
          '''Gurihage is provided "as is" without warranties of any kind. We are not liable for:

• Service interruptions or data loss
• Actions of third parties
• Indirect, incidental, or consequential damages
• Loss of profits or business opportunities

Our total liability shall not exceed the amount you paid for the service in the past 12 months.'''
    },
    {
      'id': 'disputes',
      'icon': Iconsax.scan_barcode,
      'title': 'Dispute Resolution',
      'content':
          '''Any disputes arising from these terms or your use of Gurihage shall be resolved through:

1. Informal negotiation (30 days)
2. Mediation by a mutually agreed mediator
3. Binding arbitration if mediation fails

These terms shall be governed by the laws of Somalia. You agree to submit to the jurisdiction of courts in Mogadishu for any legal proceedings.'''
    },
    {
      'id': 'changes',
      'icon': Iconsax.edit_2,
      'title': 'Changes to Terms',
      'content':
          '''We may update these Terms of Service from time to time. When we make changes:

• We will notify you through the app or email
• Changes become effective 30 days after notice
• Continued use constitutes acceptance of new terms
• You may terminate your account if you disagree

We encourage you to review these terms periodically.'''
    }
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        title: 'Term Of Service',
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

                // Introduction Card
                _buildIntroductionCard(theme),
                const SizedBox(height: 24),

                // Terms Sections (Accordion)
                _buildTermsAccordion(theme),
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
          // Gavel Icon & Title
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
                  Iconsax.edit_2,
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
                      'Terms of Service',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Effective: January 2024',
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
            'Welcome to Gurihage. These Terms of Service govern your use of our property management '
            'application and services. Please read them carefully before using our app.',
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

  // ========== TERMS ACCORDION ==========
  Widget _buildTermsAccordion(ThemeData theme) {
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
          // Terms Items
          ..._terms.map((term) {
            return _buildTermItem(theme, term);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTermItem(ThemeData theme, Map<String, dynamic> term) {
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
            term['icon'] as IconData,
            size: 18,
            color: theme.primaryColor,
          ),
        ),
        title: Text(
          term['title'] as String,
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
              term['content'] as String,
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
            'By using Gurihage, you acknowledge that you have read, understood, and agree '
            'to be bound by these Terms of Service.',
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
    title: 'Terms of Service',
    showBackButton: true,
  ),
  body: const TermsOfServiceScreen(),
);

// Direct Navigation:
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const TermsOfServiceScreen(),
  ),
);
*/
