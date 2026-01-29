// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class MainLayout extends StatelessWidget {
//   final Widget child;
//   final bool showAppBar;
//   final bool showDrawer;
//   final int currentIndex;
//   final Function(int) onTabChange;

//   const MainLayout({
//     super.key,
//     required this.child,
//     required this.currentIndex,
//     required this.onTabChange,
//     this.showAppBar = true,
//     this.showDrawer = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: showAppBar
//           ? AppBar(
//               backgroundColor: Colors.white,
//               elevation: 0,
//               title: const Text(
//                 'Bnadir, Mogadishu',
//                 style: TextStyle(color: Colors.black),
//               ),
//               iconTheme: const IconThemeData(color: Colors.black),
//             )
//           : null,
//       drawer: showDrawer ? _buildDrawer(context) : null,
//       body: child,
//       bottomNavigationBar: _buildBottomNav(),
//     );
//   }

//   // ---------------- Drawer ----------------
//   Widget _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const ListTile(
//                 leading: CircleAvatar(),
//                 title: Text('Bnadir Mogadishu'),
//                 subtitle: Text('Owner'),
//               ),
//               _drawerItem(Iconsax.home, 'Dashboard', 0),
//               _drawerItem(Iconsax.message, 'My Chats', 3),
//               _section('FINANCE'),
//               _drawerItem(Iconsax.wallet, 'Payments', -1),
//               _drawerItem(Iconsax.chart, 'Earnings Summary', -1),
//               _drawerItem(Iconsax.activity, 'Analytics', -1),
//               _section('MANAGEMENT'),
//               _drawerItem(Iconsax.warning_2, 'Complaints', -1),
//               _drawerItem(Iconsax.people, 'Tenants List', -1),
//               _drawerItem(Iconsax.call, 'Call History', -1),
//               _section('ACCOUNT'),
//               _drawerItem(Iconsax.user, 'My Profile', 4),
//               _drawerItem(Iconsax.notification, 'Notifications', -1),
//               _drawerItem(Iconsax.setting, 'App Settings', -1),
//               const Divider(),
//               ListTile(
//                 leading: const Icon(Iconsax.logout, color: Colors.red),
//                 title:
//                     const Text('Logout', style: TextStyle(color: Colors.red)),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _section(String title) {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.bold,
//           color: Colors.grey,
//         ),
//       ),
//     );
//   }

//   Widget _drawerItem(IconData icon, String title, int index) {
//     final isActive = index == currentIndex;

//     return ListTile(
//       leading:
//           Icon(icon, color: isActive ? const Color(0xFF22C55E) : Colors.grey),
//       title: Text(
//         title,
//         style: TextStyle(
//           color: isActive ? const Color(0xFF22C55E) : Colors.black,
//         ),
//       ),
//       onTap: index >= 0 ? () => onTabChange(index) : null,
//     );
//   }

//   // ---------------- Bottom Nav ----------------
//   Widget _buildBottomNav() {
//     return Container(
//       height: 78,
//       decoration: const BoxDecoration(
//         border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _bottomItem(Iconsax.home_2, 'Dashboard', 0),
//           _bottomItem(Iconsax.buildings, 'Property', 1),
//           _bottomItem(Iconsax.calendar_1, 'Booking', 2),
//           _bottomItem(Iconsax.messages_2, 'Messages', 3),
//           _bottomItem(Iconsax.profile_circle, 'Profile', 4),
//         ],
//       ),
//     );
//   }

//   Widget _bottomItem(IconData icon, String label, int index) {
//     final isActive = index == currentIndex;

//     return GestureDetector(
//       onTap: () => onTabChange(index),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon,
//               size: 26,
//               color: isActive ? const Color(0xFF22C55E) : Colors.grey),
//           const SizedBox(height: 6),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 13,
//               color: isActive ? const Color(0xFF22C55E) : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
