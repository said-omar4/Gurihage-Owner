// lib/features/profile/presentation/screens/change_password_screen.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/core/widgets/custom_appbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showNewPassword = false;
  bool _showConfirmPassword = false;
  bool _isSaving = false;

  // Password requirements
  final List<Map<String, dynamic>> _passwordRequirements = [
    {'label': 'At least 8 characters', 'regex': r'.{8,}'},
    {'label': 'Contains uppercase letter', 'regex': r'[A-Z]'},
    {'label': 'Contains lowercase letter', 'regex': r'[a-z]'},
    {'label': 'Contains a number', 'regex': r'\d'},
  ];

  List<bool> get _requirementStatus {
    final password = _newPasswordController.text;
    return _passwordRequirements.map((req) {
      final regex = RegExp(req['regex'] as String);
      return regex.hasMatch(password);
    }).toList();
  }

  bool get _allRequirementsMet {
    return _requirementStatus.every((isMet) => isMet);
  }

  bool get _passwordsMatch {
    return _newPasswordController.text == _confirmPasswordController.text &&
        _confirmPasswordController.text.isNotEmpty;
  }

  Future<void> _updatePassword() async {
    if (!_allRequirementsMet) {
      _showSnackBar(
        'Invalid password',
        'Please meet all password requirements',
        Colors.red,
      );
      return;
    }

    if (!_passwordsMatch) {
      _showSnackBar(
        'Passwords don\'t match',
        'New password and confirmation must match',
        Colors.red,
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      // TODO: Replace with your actual password update logic
      // Example with Supabase:
      // final supabase = Supabase.instance.client;
      // final { error } = await supabase.auth.updateUser(
      //   UserAttributes(password: _newPasswordController.text),
      // );
      // if (error) throw error;

      await Future.delayed(const Duration(seconds: 2));

      _showSnackBar(
        'Password updated',
        'Your password has been changed successfully',
        Colors.green,
      );

      Navigator.pop(context);
    } catch (error) {
      _showSnackBar(
        'Update failed',
        'Failed to update password. Please try again.',
        Colors.red,
      );
    } finally {
      setState(() => _isSaving = false);
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(
        title: 'Change Password',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Password Input Card
              Container(
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
                    // New Password Field
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.lock,
                                size: 20,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'New Password',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _newPasswordController,
                            obscureText: !_showNewPassword,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: 'Enter new password',
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showNewPassword
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye,
                                  size: 20,
                                  color: Colors.grey.shade500,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showNewPassword = !_showNewPassword;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1, color: Color(0xFFF1F5F9)),

                    // Confirm Password Field
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.lock,
                                size: 20,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Confirm New Password',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: !_showConfirmPassword,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: 'Confirm new password',
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showConfirmPassword
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye,
                                  size: 20,
                                  color: Colors.grey.shade500,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showConfirmPassword =
                                        !_showConfirmPassword;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (_confirmPasswordController.text.isNotEmpty)
                            Row(
                              children: [
                                Icon(
                                  _passwordsMatch ? Icons.check : Icons.close,
                                  size: 14,
                                  color: _passwordsMatch
                                      ? const Color(0xFF22C55E)
                                      : Colors.red,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _passwordsMatch
                                      ? 'Passwords match'
                                      : 'Passwords don\'t match',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _passwordsMatch
                                        ? const Color(0xFF22C55E)
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Password Requirements Card
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
                        'Password Requirements',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: List.generate(
                          _passwordRequirements.length,
                          (index) {
                            final isMet = _requirementStatus[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: isMet
                                          ? const Color(0xFF22C55E)
                                          : Colors.grey.shade200,
                                      shape: BoxShape.circle,
                                    ),
                                    child: isMet
                                        ? const Icon(
                                            Icons.check,
                                            size: 12,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _passwordRequirements[index]['label'],
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isMet
                                          ? Colors.black87
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Update Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      _isSaving || !_allRequirementsMet || !_passwordsMatch
                          ? null
                          : _updatePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22C55E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Update Password',
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
      ),
    );
  }
}
