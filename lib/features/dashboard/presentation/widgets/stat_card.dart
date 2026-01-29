// // lib/features/dashboard/presentation/widgets/stat_card.dart
// import 'package:flutter/material.dart';

// class StatCard extends StatelessWidget {
//   final String value;
//   final String label;
//   final IconData icon;
//   final Color valueColor;

//   const StatCard({
//     super.key,
//     required this.value,
//     required this.label,
//     required this.icon,
//     this.valueColor = const Color(0xFF22C55E),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(color: Colors.grey.shade200, width: 1),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       value,
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.w700,
//                         color: valueColor,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       label,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: valueColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(icon, size: 22, color: valueColor),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
