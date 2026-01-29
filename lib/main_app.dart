// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
// import '../../features/properties/presentation/screens/properties_screen.dart';
// import '../../features/bookings/presentation/screens/bookings_screen.dart';
// import '../../features/chats/presentation/screens/chats_screen.dart';
// import '../../features/profile/presentation/screens/profile_screen.dart';

// /* =======================
//    DRAWER ENUM
//    ======================= */
// enum DrawerItem {
//   dashboard,
//   properties,
//   bookings,
//   chats,
//   payments,
//   earnings,
//   analytics,
//   complaints,
//   tenants,
//   calls,
//   profile,
//   notifications,
//   settings,
// }

// /* =======================
//    MAIN LAYOUT
//    ======================= */
// class MainApp extends StatefulWidget {
//   const MainApp({super.key});

//   @override
//   State<MainApp> createState() => _MainAppState();
// }

// class _MainAppState extends State<MainApp> {
//   int _selectedIndex = 0;
//   DrawerItem _activeDrawerItem = DrawerItem.dashboard;

//   final List<Widget> _screens = const [
//     DashboardScreen(),
//     PropertiesScreen(),
//     BookingsScreen(),
//     ChatsScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final bool isProfilePage = _selectedIndex == 4;

//     return Scaffold(
//       appBar: isProfilePage ? null : _buildAppBar(),
//       drawer: isProfilePage ? null : _buildDrawer(),
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: _buildBottomNavigation(),
//     );
//   }

//   /* =======================
//      APP BAR
//      ======================= */
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       iconTheme: const IconThemeData(color: Colors.black),
//       title: Row(
//         children: const [
//           CircleAvatar(
//             radius: 16,
//             backgroundImage: AssetImage('assets/avatar.png'),
//           ),
//           SizedBox(width: 8),
//           Text(
//             'Bnadir, Mogadishu',
//             style: TextStyle(color: Colors.black, fontSize: 14),
//           ),
//           SizedBox(width: 4),
//           Icon(Iconsax.arrow_down_1, size: 18),
//         ],
//       ),
//       actions: const [
//         Icon(Iconsax.notification, color: Colors.black),
//         SizedBox(width: 12),
//       ],
//     );
//   }

//   /* =======================
//      DRAWER
//      ======================= */
//   Drawer _buildDrawer() {
//     return Drawer(
//       child: SafeArea(
//         child: ListView(
//           children: [
//             _drawerHeader(),
//             _section('MAIN'),
//             _drawerItem(DrawerItem.dashboard, Iconsax.home_2, 'Dashboard', 0),
//             _drawerItem(
//                 DrawerItem.properties, Iconsax.buildings, 'My Properties', 1),
//             _drawerItem(
//                 DrawerItem.bookings, Iconsax.calendar_1, 'My Bookings', 2),
//             _drawerItem(DrawerItem.chats, Iconsax.messages_2, 'My Chats', 3),
//             _section('ACCOUNT'),
//             _drawerItem(
//                 DrawerItem.profile, Iconsax.profile_circle, 'My Profile', 4),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Iconsax.logout, color: Colors.red),
//               title: const Text('Logout', style: TextStyle(color: Colors.red)),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _drawerHeader() {
//     return ListTile(
//       leading: const CircleAvatar(
//         backgroundImage: AssetImage('assets/avatar.png'),
//       ),
//       title: const Text('Bnadir Mogadishu'),
//       subtitle: const Text('Owner'),
//       trailing: const Icon(Iconsax.close_circle),
//       onTap: () => Navigator.pop(context),
//     );
//   }

//   Widget _section(String title) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 18, 0, 6),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 11,
//           fontWeight: FontWeight.w600,
//           color: Colors.grey,
//         ),
//       ),
//     );
//   }

//   Widget _drawerItem(
//     DrawerItem item,
//     IconData icon,
//     String title,
//     int pageIndex,
//   ) {
//     final bool isActive = _activeDrawerItem == item;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(10),
//         onTap: () {
//           setState(() {
//             _activeDrawerItem = item;
//             _selectedIndex = pageIndex;
//           });
//           Navigator.pop(context);
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             color: isActive ? const Color(0xFF22C55E) : Colors.transparent,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: ListTile(
//             dense: true,
//             leading: Icon(
//               icon,
//               size: 20,
//               color: isActive ? Colors.white : Colors.black87,
//             ),
//             title: Text(
//               title,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: isActive ? Colors.white : Colors.black87,
//                 fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /* =======================
//      BOTTOM NAV
//      ======================= */
//   Widget _buildBottomNavigation() {
//     return Container(
//       height: 78,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _bottomItem(0, Iconsax.home_2, 'Dashboard'),
//           _bottomItem(1, Iconsax.buildings, 'Property'),
//           _bottomItem(2, Iconsax.calendar_1, 'Booking'),
//           _bottomItem(3, Iconsax.messages_2, 'Messages'),
//           _bottomItem(4, Iconsax.profile_circle, 'Profile'),
//         ],
//       ),
//     );
//   }

//   Widget _bottomItem(int index, IconData icon, String label) {
//     final bool isActive = _selectedIndex == index;

//     return GestureDetector(
//       onTap: () => setState(() => _selectedIndex = index),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             icon,
//             size: 26,
//             color: isActive ? const Color(0xFF22C55E) : Colors.grey,
//           ),
//           const SizedBox(height: 6),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w500,
//               color: isActive ? const Color(0xFF22C55E) : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:xirfadsan_receipt/main_layout.dart';

// // class MainApp extends StatefulWidget {
// //   const MainApp({super.key});

// //   @override
// //   State<MainApp> createState() => _MainAppState();
// // }

// // class _MainAppState extends State<MainApp> {
// //   int _index = 0;

// //   final pages = [
// //     const Center(child: Text('Dashboard')),
// //     const Center(child: Text('Property')),
// //     const Center(child: Text('Booking')),
// //     const Center(child: Text('Chats')),
// //     const Center(child: Text('Profile')),
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return MainLayout(
// //       currentIndex: _index,
// //       onTabChange: (i) {
// //         setState(() => _index = i);
// //       },
// //       showAppBar: _index != 4,
// //       showDrawer: _index != 4,
// //       child: pages[_index],
// //     );
// //   }
// // }
