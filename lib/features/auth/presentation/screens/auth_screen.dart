// // lib/features/auth/presentation/screens/login_screen.dart
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   bool _isLoading = false;
//   bool _obscurePassword = true;
//   bool _rememberMe = false;

//   Future<void> _handleLogin() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);

//     // Simulate API call
//     await Future.delayed(const Duration(seconds: 2));

//     setState(() => _isLoading = false);

//     // Navigate to dashboard
//     Navigator.pushNamedAndRemoveUntil(
//       context,
//       '/dashboard',
//       (route) => false,
//     );

//     // Show success message
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: const Text('Login successful!'),
//         backgroundColor: Colors.green,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//     );
//   }

//   String? _validatePhone(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Phone number is required';
//     }
//     final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
//     if (digits.length < 10) {
//       return 'Enter a valid phone number';
//     }
//     return null;
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password is required';
//     }
//     if (value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               theme.primaryColor.withOpacity(0.08),
//               theme.scaffoldBackgroundColor,
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Back Button
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Iconsax.arrow_left_2),
//                     style: IconButton.styleFrom(
//                       backgroundColor: theme.cardColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Welcome Section
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Welcome Back! 👋',
//                           style: theme.textTheme.displaySmall?.copyWith(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 32,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Sign in to continue to your Gurihage account',
//                           style: theme.textTheme.bodyLarge?.copyWith(
//                             color: theme.colorScheme.onSurface.withOpacity(0.6),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 40),

//                   // Login Card
//                   Container(
//                     decoration: BoxDecoration(
//                       color: theme.cardColor,
//                       borderRadius: BorderRadius.circular(24),
//                       border: Border.all(
//                         color: theme.dividerTheme.color ?? Colors.transparent,
//                         width: 1,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 20,
//                           offset: const Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(24),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             // Phone Input
//                             _buildPhoneField(theme),
//                             const SizedBox(height: 20),

//                             // Password Input
//                             _buildPasswordField(theme),
//                             const SizedBox(height: 16),

//                             // Remember Me & Forgot Password
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 // Remember Me
//                                 Row(
//                                   children: [
//                                     Transform.scale(
//                                       scale: 0.8,
//                                       child: Checkbox(
//                                         value: _rememberMe,
//                                         onChanged: (value) => setState(
//                                             () => _rememberMe = value ?? false),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(6),
//                                         ),
//                                         activeColor: theme.primaryColor,
//                                       ),
//                                     ),
//                                     Text(
//                                       'Remember me',
//                                       style:
//                                           theme.textTheme.bodyMedium?.copyWith(
//                                         color: theme.colorScheme.onSurface
//                                             .withOpacity(0.7),
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 // Forgot Password
//                                 TextButton(
//                                   onPressed: () => Navigator.pushNamed(
//                                       context, '/forgot-password'),
//                                   style: TextButton.styleFrom(
//                                       padding: EdgeInsets.zero),
//                                   child: Text(
//                                     'Forgot Password?',
//                                     style: TextStyle(
//                                       color: theme.primaryColor,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 28),

//                             // Login Button
//                             _buildLoginButton(theme),
//                             const SizedBox(height: 32),

//                             // Divider
//                             Row(
//                               children: [
//                                 Expanded(
//                                     child: Divider(
//                                         color: theme.dividerTheme.color)),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12),
//                                   child: Text(
//                                     'or continue with',
//                                     style: theme.textTheme.bodySmall?.copyWith(
//                                       color: theme.colorScheme.onSurface
//                                           .withOpacity(0.5),
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                     child: Divider(
//                                         color: theme.dividerTheme.color)),
//                               ],
//                             ),
//                             const SizedBox(height: 24),

//                             // Social Login Buttons
//                             _buildSocialLoginButtons(theme),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 32),

//                   // Signup Link
//                   Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Don\'t have an account? ',
//                           style: theme.textTheme.bodyLarge?.copyWith(
//                             color: theme.colorScheme.onSurface.withOpacity(0.6),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () => Navigator.pushReplacementNamed(
//                               context, '/signup'),
//                           child: Text(
//                             'Sign Up',
//                             style: theme.textTheme.bodyLarge?.copyWith(
//                               color: theme.primaryColor,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Phone Field
//   Widget _buildPhoneField(ThemeData theme) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Phone Number',
//           style: theme.textTheme.bodyMedium?.copyWith(
//             fontWeight: FontWeight.w500,
//             color: theme.colorScheme.onSurface.withOpacity(0.8),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: theme.dividerTheme.color ?? Colors.grey.shade300,
//               width: 1.5,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             children: [
//               // Country Code
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Text(
//                   '+252',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                     fontWeight: FontWeight.w500,
//                     color: theme.colorScheme.onSurface.withOpacity(0.8),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: 1,
//                 height: 20,
//                 color: theme.dividerTheme.color,
//               ),
//               const SizedBox(width: 12),

//               // Phone Input
//               Expanded(
//                 child: TextFormField(
//                   controller: _phoneController,
//                   validator: _validatePhone,
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     hintText: '61 123 4567',
//                     border: InputBorder.none,
//                     hintStyle: theme.textTheme.bodyMedium?.copyWith(
//                       color: theme.colorScheme.onSurface.withOpacity(0.4),
//                     ),
//                   ),
//                   style: theme.textTheme.bodyMedium,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Password Field
//   Widget _buildPasswordField(ThemeData theme) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Password',
//           style: theme.textTheme.bodyMedium?.copyWith(
//             fontWeight: FontWeight.w500,
//             color: theme.colorScheme.onSurface.withOpacity(0.8),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: theme.dividerTheme.color ?? Colors.grey.shade300,
//               width: 1.5,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Icon(
//                   Iconsax.lock_1,
//                   size: 20,
//                   color: theme.colorScheme.onSurface.withOpacity(0.5),
//                 ),
//               ),
//               Expanded(
//                 child: TextFormField(
//                   controller: _passwordController,
//                   validator: _validatePassword,
//                   obscureText: _obscurePassword,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Enter your password',
//                     hintStyle: theme.textTheme.bodyMedium?.copyWith(
//                       color: theme.colorScheme.onSurface.withOpacity(0.4),
//                     ),
//                   ),
//                   style: theme.textTheme.bodyMedium,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () =>
//                     setState(() => _obscurePassword = !_obscurePassword),
//                 icon: Icon(
//                   _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
//                   size: 20,
//                   color: theme.colorScheme.onSurface.withOpacity(0.5),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Login Button
//   Widget _buildLoginButton(ThemeData theme) {
//     return SizedBox(
//       width: double.infinity,
//       height: 52,
//       child: ElevatedButton(
//         onPressed: _isLoading ? null : _handleLogin,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: theme.primaryColor,
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           elevation: 0,
//           shadowColor: Colors.transparent,
//         ),
//         child: _isLoading
//             ? const SizedBox(
//                 width: 20,
//                 height: 20,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   color: Colors.white,
//                 ),
//               )
//             : Text(
//                 'Sign In',
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//       ),
//     );
//   }

//   // Social Login Buttons
//   Widget _buildSocialLoginButtons(ThemeData theme) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // Google
//         Expanded(
//           child: OutlinedButton.icon(
//             onPressed: () => print('Google login'),
//             icon: const Icon(Iconsax.gallery, size: 20, color: Colors.red),
//             label: const Text('Google'),
//             style: OutlinedButton.styleFrom(
//               foregroundColor: theme.colorScheme.onSurface,
//               side: BorderSide(
//                 color: theme.dividerTheme.color ?? Colors.grey.shade300,
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),

//         // Apple
//         Expanded(
//           child: OutlinedButton.icon(
//             onPressed: () => print('Apple login'),
//             icon: const Icon(Iconsax.apple, size: 20, color: Colors.black),
//             label: const Text('Apple'),
//             style: OutlinedButton.styleFrom(
//               foregroundColor: theme.colorScheme.onSurface,
//               side: BorderSide(
//                 color: theme.dividerTheme.color ?? Colors.grey.shade300,
//               ),
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // // lib/features/auth/presentation/screens/auth_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:xirfadsan_receipt/core/theme/app_theme.dart';
// // import 'package:xirfadsan_receipt/core/widgets/ds_button.dart';
// // import 'package:xirfadsan_receipt/core/widgets/ds_card.dart';
// // import 'package:xirfadsan_receipt/features/auth/presentation/widgets/auth_tabs.dart';
// // import 'package:xirfadsan_receipt/features/auth/presentation/widgets/phone_input_field.dart';
// // import 'package:xirfadsan_receipt/features/auth/presentation/widgets/terms_checkbox.dart';

// // class AuthScreen extends StatefulWidget {
// //   const AuthScreen({super.key});

// //   @override
// //   State<AuthScreen> createState() => _AuthScreenState();
// // }

// // class _AuthScreenState extends State<AuthScreen> {
// //   final _loginFormKey = GlobalKey<FormState>();
// //   final _signupFormKey = GlobalKey<FormState>();

// //   // Login State
// //   String _loginPhone = '';
// //   String _loginEmail = '';
// //   String _loginPassword = '';

// //   // Signup State
// //   String _signupPhone = '';
// //   String _signupEmail = '';
// //   String _signupPassword = '';
// //   String _confirmPassword = '';
// //   bool _acceptTerms = false;

// //   bool _isLoading = false;
// //   int _selectedTab = 0; // 0 = Login, 1 = Signup

// //   Future<void> _handleLogin() async {
// //     if (!_loginFormKey.currentState!.validate()) return;

// //     setState(() => _isLoading = true);

// //     // TODO: Implement actual login logic
// //     await Future.delayed(const Duration(seconds: 2));

// //     setState(() => _isLoading = false);

// //     // Navigate to dashboard on success
// //     // context.go('/dashboard');

// //     // Show error on failure
// //     // ScaffoldMessenger.of(context).showSnackBar(
// //     //   SnackBar(content: Text('Login failed')),
// //     // );
// //   }

// //   Future<void> _handleSignup() async {
// //     if (!_signupFormKey.currentState!.validate()) return;

// //     if (_signupPassword != _confirmPassword) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Passwords do not match')),
// //       );
// //       return;
// //     }

// //     if (!_acceptTerms) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Please accept terms and conditions')),
// //       );
// //       return;
// //     }

// //     setState(() => _isLoading = true);

// //     // TODO: Implement actual signup logic
// //     await Future.delayed(const Duration(seconds: 2));

// //     setState(() => _isLoading = false);

// //     // Navigate to dashboard on success
// //     // context.go('/dashboard');
// //   }

// //   String? _validateEmail(String? value) {
// //     if (value == null || value.isEmpty) {
// //       return 'Email is required';
// //     }
// //     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
// //       return 'Enter a valid email';
// //     }
// //     return null;
// //   }

// //   String? _validatePassword(String? value) {
// //     if (value == null || value.isEmpty) {
// //       return 'Password is required';
// //     }
// //     if (value.length < 6) {
// //       return 'Password must be at least 6 characters';
// //     }
// //     return null;
// //   }

// //   String? _validatePhone(String? value) {
// //     if (value == null || value.isEmpty) {
// //       return 'Phone number is required';
// //     }
// //     if (value.length < 10) {
// //       return 'Phone must be at least 10 digits';
// //     }
// //     return null;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //             colors: [
// //               AppColors.backgroundLight,
// //               AppColors.backgroundLight.withOpacity(0.95),
// //             ],
// //           ),
// //         ),
// //         child: Center(
// //           child: SingleChildScrollView(
// //             child: Padding(
// //               padding: const EdgeInsets.all(20.0),
// //               child: DSCard(
// //                 backgroundColor: Colors.white,
// //                 padding: const EdgeInsets.all(24),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     // Logo Section
// //                     _buildLogoSection(),
// //                     const SizedBox(height: 24),

// //                     // App Title
// //                     Text(
// //                       'Gurihage',
// //                       style:
// //                           Theme.of(context).textTheme.displayMedium?.copyWith(
// //                                 color: AppColors.primaryLight,
// //                                 fontWeight: FontWeight.w700,
// //                               ),
// //                     ),
// //                     Text(
// //                       'Home Rent App',
// //                       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
// //                             color: AppColors.mutedForegroundLight,
// //                           ),
// //                     ),
// //                     const SizedBox(height: 32),

// //                     // Tabs
// //                     AuthTabs(
// //                       selectedIndex: _selectedTab,
// //                       onTabChanged: (index) {
// //                         setState(() => _selectedTab = index);
// //                       },
// //                     ),
// //                     const SizedBox(height: 24),

// //                     // Forms
// //                     _selectedTab == 0 ? _buildLoginForm() : _buildSignupForm(),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildLogoSection() {
// //     return Container(
// //       width: 100,
// //       height: 100,
// //       decoration: BoxDecoration(
// //         color: AppColors.primaryLight.withOpacity(0.1),
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       child: Center(
// //         child: Icon(
// //           Icons.home_rounded,
// //           size: 50,
// //           color: AppColors.primaryLight,
// //         ),
// //       ),
// //     );

// //     // If you have actual logo image:
// //     // return Image.asset(
// //     //   'assets/images/gurihage-logo.png',
// //     //   height: 80,
// //     // );
// //   }

// //   Widget _buildLoginForm() {
// //     return Form(
// //       key: _loginFormKey,
// //       child: Column(
// //         children: [
// //           // Phone Input
// //           PhoneInputField(
// //             label: 'Phone number',
// //             onChanged: (value) => _loginPhone = value,
// //             validator: _validatePhone,
// //           ),
// //           const SizedBox(height: 16),

// //           // Password
// //           TextFormField(
// //             decoration: InputDecoration(
// //               labelText: 'Password',
// //               hintText: 'Enter your password',
// //               prefixIcon: const Icon(Icons.lock_outline),
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //             ),
// //             obscureText: true,
// //             onChanged: (value) => _loginPassword = value,
// //             validator: _validatePassword,
// //           ),
// //           const SizedBox(height: 8),

// //           // Forgot Password
// //           Align(
// //             alignment: Alignment.centerRight,
// //             child: TextButton(
// //               onPressed: () {
// //                 // Navigate to forgot password
// //                 // context.push('/forgot-password');
// //               },
// //               child: Text(
// //                 'Forgot password?',
// //                 style: TextStyle(color: AppColors.primaryLight),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 16),

// //           // Login Button
// //           DSButton(
// //             text: 'Sign In',
// //             onPressed: _handleLogin,
// //             fullWidth: true,
// //             isLoading: _isLoading,
// //             borderRadius: 30,
// //           ),
// //           const SizedBox(height: 16),

// //           // Signup Link
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Text(
// //                 'Don\'t have an account? ',
// //                 style: Theme.of(context).textTheme.bodyMedium,
// //               ),
// //               TextButton(
// //                 onPressed: () => setState(() => _selectedTab = 1),
// //                 style: TextButton.styleFrom(padding: EdgeInsets.zero),
// //                 child: Text(
// //                   'Sign Up',
// //                   style: TextStyle(
// //                     color: AppColors.primaryLight,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildSignupForm() {
// //     return Form(
// //       key: _signupFormKey,
// //       child: Column(
// //         children: [
// //           // Phone Input
// //           PhoneInputField(
// //             label: 'Phone number',
// //             onChanged: (value) => _signupPhone = value,
// //             validator: _validatePhone,
// //           ),
// //           const SizedBox(height: 16),

// //           // Email
// //           TextFormField(
// //             decoration: InputDecoration(
// //               labelText: 'Email',
// //               hintText: 'Enter your email address',
// //               prefixIcon: const Icon(Icons.email_outlined),
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //             ),
// //             keyboardType: TextInputType.emailAddress,
// //             onChanged: (value) => _signupEmail = value,
// //             validator: _validateEmail,
// //           ),
// //           const SizedBox(height: 16),

// //           // Password
// //           TextFormField(
// //             decoration: InputDecoration(
// //               labelText: 'Password',
// //               hintText: 'Enter your password',
// //               prefixIcon: const Icon(Icons.lock_outline),
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //             ),
// //             obscureText: true,
// //             onChanged: (value) => _signupPassword = value,
// //             validator: _validatePassword,
// //           ),
// //           const SizedBox(height: 16),

// //           // Confirm Password
// //           TextFormField(
// //             decoration: InputDecoration(
// //               labelText: 'Confirm Password',
// //               hintText: 'Confirm your password',
// //               prefixIcon: const Icon(Icons.lock_outline),
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //             ),
// //             obscureText: true,
// //             onChanged: (value) => _confirmPassword = value,
// //             validator: (value) {
// //               if (value != _signupPassword) {
// //                 return 'Passwords do not match';
// //               }
// //               return null;
// //             },
// //           ),
// //           const SizedBox(height: 16),

// //           // Terms Checkbox
// //           TermsCheckbox(
// //             value: _acceptTerms,
// //             onChanged: (value) => setState(() => _acceptTerms = value ?? false),
// //           ),
// //           const SizedBox(height: 24),

// //           // Signup Button
// //           DSButton(
// //             text: 'Sign Up',
// //             onPressed: _handleSignup,
// //             fullWidth: true,
// //             isLoading: _isLoading,
// //             borderRadius: 30,
// //           ),
// //           const SizedBox(height: 16),

// //           // Login Link
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Text(
// //                 'Already have an account? ',
// //                 style: Theme.of(context).textTheme.bodyMedium,
// //               ),
// //               TextButton(
// //                 onPressed: () => setState(() => _selectedTab = 0),
// //                 style: TextButton.styleFrom(padding: EdgeInsets.zero),
// //                 child: Text(
// //                   'Login',
// //                   style: TextStyle(
// //                     color: AppColors.primaryLight,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
