// // lib/features/profile/presentation/widgets/logout_dialog.dart
// import 'package:flutter/material.dart';

// class LogoutDialog extends StatelessWidget {
//   const LogoutDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colors = theme.colorScheme;

//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       title: Text(
//         'Are you sure you want to logout?',
//         style: theme.textTheme.titleMedium?.copyWith(
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       content: Text(
//         'You will need to sign in again to access your account.',
//         style: theme.textTheme.bodyMedium?.copyWith(
//           color: colors.onSurface.withOpacity(0.7),
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context, false),
//           child: Text(
//             'Cancel',
//             style: theme.textTheme.bodyMedium?.copyWith(
//               color: colors.onSurface.withOpacity(0.7),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () => Navigator.pop(context, true),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: colors.error,
//             foregroundColor: Colors.white,
//           ),
//           child: Text(
//             'Logout',
//             style: theme.textTheme.bodyMedium?.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
