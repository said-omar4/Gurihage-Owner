// lib/features/profile/presentation/screens/edit_profile_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xirfadsan_receipt/core/widgets/custom_appbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // User data
  final String _userName = "Said-Omar Ahmed";
  final String _userEmail = "said4656@gmail.com";
  final String _userId = "user_123";

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // State variables
  XFile? _selectedImage;
  bool _isLoading = false;
  bool _isSaving = false;
  bool _isUploading = false;
  String _avatarUrl = '';
  String _phoneError = '';
  String _nameError = '';

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    setState(() => _isLoading = true);

    // TODO: Replace with your actual data fetching
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _nameController.text = _userName;
      _emailController.text = _userEmail;
      _phoneController.text = "+252612345678";
      _avatarUrl = 'https://api.dicebear.com/7.x/avataaars/svg?seed=$_userId';
      _isLoading = false;
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _selectedImage = image;
        _isUploading = true;
      });

      // Simulate upload
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isUploading = false;
        // TODO: Upload image to your backend
        // _avatarUrl = uploadedImageUrl;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile image updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  bool _validateForm() {
    bool isValid = true;
    String phoneError = '';
    String nameError = '';

    // Validate phone number
    final phone = _phoneController.text.trim();
    if (phone.isNotEmpty) {
      final phoneRegex = RegExp(r'^\+?[0-9\s\-\(\)]{10,}$');
      if (!phoneRegex.hasMatch(phone)) {
        phoneError = 'Please enter a valid phone number';
        isValid = false;
      }
    }

    // Validate full name
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      nameError = 'Full name is required';
      isValid = false;
    } else if (name.length < 2) {
      nameError = 'Name must be at least 2 characters';
      isValid = false;
    }

    setState(() {
      _phoneError = phoneError;
      _nameError = nameError;
    });

    return isValid;
  }

  Future<void> _saveProfile() async {
    if (!_validateForm()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors before saving'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      // TODO: Replace with your actual save logic
      await Future.delayed(const Duration(seconds: 2));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: $error'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  String _getInitials() {
    final name =
        _nameController.text.isNotEmpty ? _nameController.text : _userName;

    if (name.isNotEmpty) {
      final names = name.split(' ');
      if (names.length > 1) {
        return '${names[0][0]}${names[1][0]}';
      }
      return name[0];
    }
    return 'U';
  }

  // Fix: Proper image provider
  ImageProvider? _getImageProvider() {
    if (_selectedImage != null) {
      return FileImage(File(_selectedImage!.path));
    } else if (_avatarUrl.isNotEmpty) {
      return NetworkImage(_avatarUrl);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomAppBar(
        title: 'Edit Profile',
        showBackButton: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    // Avatar Section
                    Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Avatar
                            Container(
                              width: 112,
                              height: 112,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color:
                                      const Color(0xFF22C55E).withOpacity(0.2),
                                  width: 4,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 56,
                                backgroundColor:
                                    const Color(0xFF22C55E).withOpacity(0.1),
                                backgroundImage: _getImageProvider(),
                                child: _getImageProvider() == null
                                    ? Text(
                                        _getInitials(),
                                        style: const TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF22C55E),
                                        ),
                                      )
                                    : null,
                              ),
                            ),

                            // Camera Button
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF22C55E),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                ),
                                child: IconButton(
                                  icon: _isUploading
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Icon(
                                          Iconsax.camera,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                  onPressed: _isUploading ? null : _pickImage,
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Tap the camera icon to change photo',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Form Fields
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          // Full Name Field
                          _buildFormField(
                            icon: Iconsax.user,
                            label: 'Full Name',
                            controller: _nameController,
                            hintText: 'Enter your full name',
                            errorText: _nameError,
                          ),

                          const Divider(height: 1, color: Color(0xFFF1F5F9)),

                          // Email Field (Disabled)
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Iconsax.sms,
                                      size: 20,
                                      color: Colors.grey.shade600,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Email',
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
                                  controller: _emailController,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your email',
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
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Email cannot be changed',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Divider(height: 1, color: Color(0xFFF1F5F9)),

                          // Phone Number Field
                          _buildFormField(
                            icon: Iconsax.call,
                            label: 'Phone Number',
                            controller: _phoneController,
                            hintText:
                                'Enter your phone number (e.g., +252612345678)',
                            errorText: _phoneError,
                            keyboardType: TextInputType.phone,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildFormField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required String hintText,
    String? errorText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: errorText != null ? Colors.red : Colors.grey.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: errorText != null ? Colors.red : Colors.grey.shade300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFF22C55E),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            onChanged: (_) {
              if (errorText != null) {
                setState(() {
                  if (label.toLowerCase().contains('phone')) {
                    _phoneError = '';
                  } else if (label.toLowerCase().contains('name')) {
                    _nameError = '';
                  }
                });
              }
            },
          ),
          if (errorText != null && errorText.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              errorText,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
