// lib/features/support/presentation/screens/faq_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/core/widgets/custom_appbar.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  // FAQ data
  final List<Map<String, String>> _faqs = [
    {
      'question': 'How do I add a new property?',
      'answer':
          'To add a new property, go to the Properties tab and tap the "+" button. Fill in the property details including name, address, and other relevant information, then save.',
    },
    {
      'question': 'How do I add tenants to my property?',
      'answer':
          'Navigate to your property details, then tap "View Tenants". From there, you can add new tenants by providing their name, email, phone number, and move-in date.',
    },
    {
      'question': 'How do I record rent payments?',
      'answer':
          'Go to the Payments section from the menu drawer. Tap "Add Payment" and select the property, tenant, amount, and payment method. The payment will be recorded and appear in the tenant\'s payment history.',
    },
    {
      'question': 'Can I communicate with my tenants through the app?',
      'answer':
          'Yes! You can chat with your tenants directly through the Chats tab. You can also make voice and video calls to stay connected with your tenants.',
    },
    {
      'question': 'How do I handle tenant complaints?',
      'answer':
          'Tenant complaints appear in the Complaints section accessible from the menu. You can view details, respond to complaints, and mark them as resolved once addressed.',
    },
    {
      'question': 'How do I view my earnings?',
      'answer':
          'Your earnings summary is available in the Earnings section from the menu drawer. You can see total income, monthly breakdowns, and export reports.',
    },
    {
      'question': 'What if I forget my password?',
      'answer':
          'On the login screen, tap "Forgot Password". Enter your email address and we\'ll send you a link to reset your password.',
    },
    {
      'question': 'How do I update my profile information?',
      'answer':
          'Go to Profile from the menu, then tap "Edit Profile". You can update your name, phone number, and profile picture.',
    },
    {
      'question': 'Can I create group chats with multiple tenants?',
      'answer':
          'Yes! In the Chats tab, tap "Create Group" to start a new group chat. You can add multiple tenants from your properties to a single conversation.',
    },
    {
      'question': 'How do I enable push notifications?',
      'answer':
          'Go to Profile > Notifications to manage your notification preferences. You can enable/disable push notifications and customize alerts for payments, bookings, complaints, and messages.',
    },
  ];

  // Track which FAQ is expanded
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(
        title: 'FAQ',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header Info
              Container(
                padding: const EdgeInsets.all(24),
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
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Iconsax.message_question,
                        size: 32,
                        color: Color(0xFF22C55E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Find answers to common questions about using Gurihage',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // FAQ List
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _faqs.length,
                itemBuilder: (context, index) {
                  final faq = _faqs[index];
                  final isExpanded = _expandedIndex == index;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _expandedIndex = isExpanded ? null : index;
                          });
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Question Row
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      faq['question']!,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Icon(
                                    isExpanded
                                        ? Iconsax.arrow_up_2
                                        : Iconsax.arrow_down_1,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),

                              // Answer (Expanded)
                              if (isExpanded) ...[
                                const SizedBox(height: 12),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: const Color(0xFFF1F5F9),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  faq['answer']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Contact Support Section
              Container(
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
                    const Text(
                      "Can't find what you're looking for?",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to support screen
                          print('Navigate to Support');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF22C55E),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                        ),
                        child: const Text(
                          'Contact Support',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
