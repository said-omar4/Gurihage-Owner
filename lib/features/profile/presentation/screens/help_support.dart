// lib/features/support/presentation/screens/help_support_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/core/widgets/custom_appbar.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  // Form data
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String _selectedCategory = '';
  bool _isSending = false;

  // Support categories
  final List<String> _categories = [
    'Account Issues',
    'Payments & Billing',
    'Property Management',
    'Technical Problems',
    'Feature Request',
    'Other',
  ];

  // Quick action options
  final List<Map<String, dynamic>> _supportOptions = [
    {
      'icon': Iconsax.call,
      'title': 'Call Support',
      'description': 'Speak directly with our team',
      'action': 'call',
    },
    {
      'icon': Iconsax.message,
      'title': 'Live Chat',
      'description': 'Chat with support team',
      'action': 'chat',
    },
    {
      'icon': Iconsax.message_question,
      'title': 'FAQ',
      'description': 'Browse common questions',
      'action': 'faq',
    },
  ];

  Future<void> _handleSubmit() async {
    // Validate form
    if (_selectedCategory.isEmpty ||
        _subjectController.text.isEmpty ||
        _messageController.text.isEmpty) {
      _showSnackBar('Missing fields', 'Please fill in all fields', Colors.red);
      return;
    }

    setState(() => _isSending = true);

    try {
      // TODO: Replace with your actual submit logic
      // Example: Send support request to your backend
      await Future.delayed(const Duration(seconds: 2));

      _showSnackBar(
        'Request submitted',
        'Our support team will get back to you within 24 hours',
        Colors.green,
      );

      // Clear form
      setState(() {
        _selectedCategory = '';
        _subjectController.clear();
        _messageController.clear();
      });
    } catch (error) {
      _showSnackBar(
        'Submission failed',
        'Failed to submit request. Please try again.',
        Colors.red,
      );
    } finally {
      setState(() => _isSending = false);
    }
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case 'call':
        // Navigate to call center
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const CallCenterScreen()));
        print('Navigate to Call Center');
        break;
      case 'chat':
        // Navigate to chat
        print('Navigate to Live Chat');
        break;
      case 'faq':
        // Navigate to FAQ
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const FaqScreen()));
        print('Navigate to FAQ');
        break;
    }
  }

  void _showSnackBar(String title, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            Text(
              message,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(
        title: 'Help & Support',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Quick Actions Grid
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: _supportOptions.length,
                itemBuilder: (context, index) {
                  final option = _supportOptions[index];
                  return GestureDetector(
                    onTap: () => _handleQuickAction(option['action']),
                    child: Container(
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
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFF22C55E).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                option['icon'] as IconData,
                                size: 24,
                                color: const Color(0xFF22C55E),
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Title
                            Text(
                              option['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),

                            const SizedBox(height: 4),

                            // Description
                            Text(
                              option['description'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Support Form Card
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
                      // Form Header
                      Row(
                        children: [
                          const Icon(
                            Iconsax.sms,
                            size: 20,
                            color: Color(0xFF22C55E),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Submit a Request',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Category Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCategory.isEmpty
                                    ? null
                                    : _selectedCategory,
                                isExpanded: true,
                                hint: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    'Select category',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                items: _categories.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Text(value),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedCategory = newValue ?? '';
                                  });
                                },
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Subject Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Subject',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _subjectController,
                            decoration: InputDecoration(
                              hintText: 'Brief description of your issue',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF22C55E),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Message Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Message',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _messageController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: 'Describe your issue in detail...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF22C55E),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isSending ? null : _handleSubmit,
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
                          child: _isSending
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Iconsax.send_2, size: 20),
                                    SizedBox(width: 8),
                                    Text(
                                      'Submit Request',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Contact Info Card
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
                      const Text(
                        'Other Ways to Reach Us',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Contact Methods
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.sms,
                                size: 16,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'support@gurihage.com',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Iconsax.call,
                                size: 16,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                '+252 61 234 5678',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Note
                      Text(
                        'Our support team typically responds within 24 hours during business days.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
