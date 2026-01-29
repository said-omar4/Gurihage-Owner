// lib/features/support/presentation/screens/call_center_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xirfadsan_receipt/core/widgets/custom_appbar.dart';

class CallCenterScreen extends StatefulWidget {
  const CallCenterScreen({super.key});

  @override
  State<CallCenterScreen> createState() => _CallCenterScreenState();
}

class _CallCenterScreenState extends State<CallCenterScreen> {
  bool _isCalling = false;

  // Company contact information
  final Map<String, String> _companyInfo = {
    'name': 'Gurihage Support',
    'phone': '+252 61 234 5678',
    'email': 'support@gurihage.com',
    'address': 'Mogadishu, Somalia',
    'hours': '24/7 Available',
  };

  Future<void> _makePhoneCall() async {
    setState(() => _isCalling = true);

    final phoneNumber = _companyInfo['phone']!.replaceAll(' ', '');
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        throw 'Could not launch phone app';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to make call: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() => _isCalling = false);
        }
      });
    }
  }

  Future<void> _openWhatsApp() async {
    final phoneNumber =
        _companyInfo['phone']!.replaceAll(RegExp(r'[^0-9]'), '');
    final message = 'Hello, I need support from Gurihage.';
    final url =
        'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}';

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch WhatsApp';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to open WhatsApp: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _sendEmail() async {
    final email = _companyInfo['email']!;
    final subject = 'Support Request';
    final url = 'mailto:$email?subject=${Uri.encodeComponent(subject)}';

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch email app';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to open email: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (iconColor ?? const Color(0xFF22C55E)).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor ?? const Color(0xFF22C55E),
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
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
      appBar: const CustomAppBar(
        title: 'Call Center',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Company Info Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
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
                child: Column(
                  children: [
                    // Header with Logo
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E).withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Logo/Avatar
                          Container(
                            width: 96,
                            height: 96,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF22C55E),
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'G',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Company Name
                          Text(
                            _companyInfo['name']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 4),

                          // Tagline
                          const Text(
                            'Official Support Team',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Contact Details
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        spacing: 12,
                        children: [
                          _buildContactItem(
                            icon: Iconsax.call,
                            title: 'Phone',
                            value: _companyInfo['phone']!,
                          ),
                          const SizedBox(height: 12),
                          _buildContactItem(
                            icon: Iconsax.sms,
                            title: 'Email',
                            value: _companyInfo['email']!,
                          ),
                          const SizedBox(height: 12),
                          _buildContactItem(
                            icon: Iconsax.location,
                            title: 'Address',
                            value: _companyInfo['address']!,
                          ),
                          const SizedBox(height: 12),
                          _buildContactItem(
                            icon: Iconsax.clock,
                            title: 'Working Hours',
                            value: _companyInfo['hours']!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Action Buttons
              Column(
                children: [
                  // Call Now Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isCalling ? null : _makePhoneCall,
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
                        elevation: 0,
                      ),
                      child: _isCalling
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
                                Icon(Iconsax.call, size: 20),
                                SizedBox(width: 12),
                                Text(
                                  'Call Now',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // WhatsApp Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _openWhatsApp,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF25D366),
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        foregroundColor: const Color(0xFF25D366),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.message, size: 20),
                          SizedBox(width: 12),
                          Text(
                            'WhatsApp',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Email Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _sendEmail,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        foregroundColor: Colors.black87,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.sms, size: 20),
                          SizedBox(width: 12),
                          Text(
                            'Send Email',
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

              const SizedBox(height: 24),

              // About Company Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Iconsax.buildings,
                        size: 20,
                        color: const Color(0xFF22C55E),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'About Gurihage',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Gurihage is your trusted property management platform. Our support team is available 24/7 to assist you with any questions or concerns about your properties and tenants.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                            ),
                          ],
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
    );
  }
}
