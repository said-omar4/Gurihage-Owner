// // lib/features/dashboard/presentation/widgets/quick_action_button.dart
// import 'package:flutter/material.dart';

// class QuickActionButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onPressed;
//   final Color backgroundColor;

//   const QuickActionButton({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.onPressed,
//     this.backgroundColor = const Color(0xFF22C55E),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: backgroundColor,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         elevation: 0,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 28),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
