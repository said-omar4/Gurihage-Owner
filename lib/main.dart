import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:xirfadsan_receipt/features/bookings/presentation/screens/bookings_screen.dart';
import 'package:xirfadsan_receipt/features/chats/presentation/screens/chats_screen.dart';
import 'package:xirfadsan_receipt/features/profile/presentation/screens/profile_screen.dart';
import 'package:xirfadsan_receipt/features/properties/presentation/screens/properties_screen.dart';
import 'appbar.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gurihage',
      debugShowCheckedModeBanner: false,
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  DrawerItem _activeDrawerItem = DrawerItem.dashboard;

  Widget _getCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return const DashboardScreen();
      case 1:
        return const PropertiesScreen();
      case 2:
        return const BookingsScreen();
      case 3:
        return const ChatsScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const DashboardScreen();
    }
  }

  void _handleDrawerTap(DrawerItem item) {
    setState(() => _activeDrawerItem = item);

    // MAIN 5 SCREENS → POP BACK TO MAINAPP
    if (item == DrawerItem.dashboard) {
      Navigator.popUntil(context, (route) => route.isFirst);
      return setState(() => _selectedIndex = 0);
    }

    if (item == DrawerItem.properties) {
      Navigator.popUntil(context, (route) => route.isFirst);
      return setState(() => _selectedIndex = 1);
    }

    if (item == DrawerItem.bookings) {
      Navigator.popUntil(context, (route) => route.isFirst);
      return setState(() => _selectedIndex = 2);
    }

    if (item == DrawerItem.chats) {
      Navigator.popUntil(context, (route) => route.isFirst);
      return setState(() => _selectedIndex = 3);
    }

    if (item == DrawerItem.profile) {
      Navigator.popUntil(context, (route) => route.isFirst);
      return setState(() => _selectedIndex = 4);
    }

    // OTHER SCREENS
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: CustomAppBar.buildAppBar(context),
          drawer: CustomAppBar.buildDrawer(context, item, _handleDrawerTap),
          body: getScreen(item),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar(context),
      drawer: CustomAppBar.buildDrawer(
        context,
        _activeDrawerItem,
        _handleDrawerTap,
      ),
      body: _getCurrentScreen(),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 85,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomItem(0, Iconsax.home_2, 'Dashboard'),
          _bottomItem(1, Iconsax.buildings, 'Property'),
          _bottomItem(2, Iconsax.calendar_1, 'Booking'),
          _bottomItem(3, Iconsax.messages_2, 'Messages'),
          _bottomItem(4, Iconsax.profile_circle, 'Profile'),
        ],
      ),
    );
  }

  Widget _bottomItem(int index, IconData icon, String label) {
    final bool isActive = _selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: 26,
              color: isActive ? const Color(0xFF22C55E) : Colors.grey),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isActive ? const Color(0xFF22C55E) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:iconsax/iconsax.dart';

// import 'package:xirfadsan_receipt/features/Earning/earning_screen.dart';
// import 'package:xirfadsan_receipt/features/Tenant%20List/tenant_list.dart';
// import 'package:xirfadsan_receipt/features/complaint/complaint.dart';
// import 'package:xirfadsan_receipt/features/dashboard/presentation/screens/dashboard_screen.dart';
// import 'package:xirfadsan_receipt/features/bookings/presentation/screens/bookings_screen.dart';
// import 'package:xirfadsan_receipt/features/chats/presentation/screens/chats_screen.dart';
// import 'package:xirfadsan_receipt/features/profile/presentation/screens/profile_screen.dart';
// import 'package:xirfadsan_receipt/features/properties/presentation/screens/properties_screen.dart';

// import 'appbar.dart';

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true,
//       builder: (context) => const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MainApp(),
//     );
//   }
// }

// class MainApp extends StatefulWidget {
//   const MainApp({super.key});

//   @override
//   State<MainApp> createState() => _MainAppState();
// }

// class _MainAppState extends State<MainApp> {
//   int _selectedIndex = 0;

//   late final List<Widget> screens;

//   @override
//   void initState() {
//     super.initState();

//     screens = [
//       DashboardScreen(onNavigate: _navigateFromQuickAction), // 0
//       PropertiesScreen(), // 1
//       BookingsScreen(), // 2
//       ChatsScreen(), // 3
//       ProfileScreen(), // 4
//       ComplaintsScreen(), // 5
//       EarningsScreen(), // 6
//       TenantsScreen(), // 7
//     ];
//   }

//   /// Quick action navigation
//   void _navigateFromQuickAction(int index) {
//     setState(() => _selectedIndex = index);
//   }

//   /// Drawer navigation
//   void _handleDrawerTap(DrawerItem item) {
//     switch (item) {
//       case DrawerItem.dashboard:
//         _selectedIndex = 0;
//         break;
//       case DrawerItem.properties:
//         _selectedIndex = 1;
//         break;
//       case DrawerItem.bookings:
//         _selectedIndex = 2;
//         break;
//       case DrawerItem.chats:
//         _selectedIndex = 3;
//         break;
//       case DrawerItem.profile:
//         _selectedIndex = 4;
//         break;
//       case DrawerItem.complaints:
//         _selectedIndex = 5;
//         break;
//       case DrawerItem.earnings:
//         _selectedIndex = 6;
//         break;
//       case DrawerItem.tenants:
//         _selectedIndex = 7;
//         break;
//       default:
//         _selectedIndex = 0;
//     }

//     setState(() {});
//     Navigator.pop(context);
//   }

//   /// ✅ BottomNav condition
//   bool get showBottomNav {
//     return !(_selectedIndex == 5 || _selectedIndex == 6 || _selectedIndex == 7);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar.buildAppBar(context),
//       drawer: CustomAppBar.buildDrawer(
//         context,
//         DrawerItem.dashboard,
//         _handleDrawerTap,
//       ),
//       body: screens[_selectedIndex],

//       /// CONDITION HALKAN
//       bottomNavigationBar: showBottomNav ? _buildBottomNavigation() : null,
//     );
//   }

//   Widget _buildBottomNavigation() {
//     return Container(
//       height: 85,
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
//     final isActive = _selectedIndex == index;

//     return GestureDetector(
//       onTap: () => setState(() => _selectedIndex = index),
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
//               fontWeight: FontWeight.w500,
//               color: isActive ? const Color(0xFF22C55E) : Colors.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

/////////////
// import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:xirfadsan_receipt/features/dashboard/presentation/screens/dashboard_screen.dart';
// import 'package:xirfadsan_receipt/features/bookings/presentation/screens/bookings_screen.dart';
// import 'package:xirfadsan_receipt/features/chats/presentation/screens/chats_screen.dart';
// import 'package:xirfadsan_receipt/features/profile/presentation/screens/profile_screen.dart';
// import 'package:xirfadsan_receipt/features/properties/presentation/screens/properties_screen.dart';
// import 'appbar.dart';

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true,
//       builder: (context) => const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Gurihage',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color(0xFF22C55E),
//         useMaterial3: true,
//       ),
//       home: const MainApp(),
//     );
//   }
// }

// class MainApp extends StatefulWidget {
//   const MainApp({super.key});

//   @override
//   State<MainApp> createState() => _MainAppState();
// }

// class _MainAppState extends State<MainApp> {
//   int _selectedIndex = 0;
//   DrawerItem _activeDrawerItem = DrawerItem.dashboard;

//   // ✅ NO APPBAR IN MAIN.DART
//   // ✅ Screens will handle their own AppBar

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // 🚫 NO APPBAR HERE
//       // appBar: CustomAppBar.buildAppBar(context), // REMOVED

//       // Drawer stays
//       drawer: CustomAppBar.buildDrawer(context, _activeDrawerItem, (item) {
//         setState(() => _activeDrawerItem = item);
//       }),

//       // Body with current screen
//       body: _getCurrentScreen(),

//       // Bottom navigation stays
//       bottomNavigationBar: _buildBottomNavigation(),
//     );
//   }

//   // Method to get current screen WITH its own AppBar
//   Widget _getCurrentScreen() {
//     switch (_selectedIndex) {
//       case 0:
//         return const DashboardScreen();
//       case 1:
//         return const PropertiesScreen();
//       case 2:
//         return const BookingsScreen();
//       case 3:
//         return const ChatsScreen();
//       case 4:
//         return const ProfileScreen();
//       default:
//         return const DashboardScreen();
//     }
//   }

//   Widget _buildBottomNavigation() {
//     return Container(
//       height: 85,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           top: BorderSide(color: Color(0xFFE5E7EB)),
//         ),
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
//       onTap: () {
//         setState(() {
//           _selectedIndex = index;
//         });
//       },
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

// import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:xirfadsan_receipt/features/dashboard/presentation/screens/dashboard_screen.dart';
// import 'package:xirfadsan_receipt/features/bookings/presentation/screens/bookings_screen.dart';
// import 'package:xirfadsan_receipt/features/chats/presentation/screens/chats_screen.dart';
// import 'package:xirfadsan_receipt/features/profile/presentation/screens/profile_screen.dart';
// import 'package:xirfadsan_receipt/features/properties/presentation/screens/properties_screen.dart';
// import 'appbar.dart'; // import garee appbar.dart

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true,
//       builder: (context) => const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Gurihage',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color(0xFF22C55E),
//         useMaterial3: true,
//       ),
//       home: const MainApp(),
//     );
//   }
// }

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
//     return Scaffold(
//       appBar: CustomAppBar.buildAppBar(context),
//       drawer: CustomAppBar.buildDrawer(context, _activeDrawerItem, (item) {
//         setState(() => _activeDrawerItem = item);
//       }),
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: _buildBottomNavigation(),
//     );
//   }

//   Widget _buildBottomNavigation() {
//     return Container(
//       height: 85,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           top: BorderSide(color: Color(0xFFE5E7EB)),
//         ),
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
//       onTap: () {
//         setState(() {
//           _selectedIndex = index;
//         });
//       },
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

// import 'package:flutter/material.dart';
// import 'package:device_preview/device_preview.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:xirfadsan_receipt/features/Payment/payments_screen.dart';
// import 'package:xirfadsan_receipt/features/dashboard/presentation/screens/dashboard_screen.dart';
// import 'package:xirfadsan_receipt/features/bookings/presentation/screens/bookings_screen.dart';
// import 'package:xirfadsan_receipt/features/chats/presentation/screens/chats_screen.dart';
// import 'package:xirfadsan_receipt/features/profile/presentation/screens/profile_screen.dart';
// import 'package:xirfadsan_receipt/features/properties/presentation/screens/properties_screen.dart';

// void main() {
//   runApp(
//     DevicePreview(
//       enabled: true,
//       builder: (context) => const MyApp(),
//     ),
//   );
// }

// /* =======================
//    APP ROOT
//    ======================= */
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Gurihage',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: const Color(0xFF22C55E),
//         useMaterial3: true,
//       ),
//       home: const MainApp(),
//     );
//   }
// }

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
//    MAIN APP
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
//     return Scaffold(
//       appBar: _buildAppBar(),
//       drawer: _buildDrawer(),
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
//             _drawerItem(DrawerItem.dashboard, Iconsax.home_2, 'Dashboard'),
//             _drawerItem(
//                 DrawerItem.properties, Iconsax.buildings, 'My Properties'),
//             _drawerItem(DrawerItem.bookings, Iconsax.calendar_1, 'My Bookings'),
//             _drawerItem(DrawerItem.chats, Iconsax.messages_2, 'My Chats'),
//             _section('FINANCE'),
//             _drawerItem(DrawerItem.payments, Iconsax.card, 'Payments'),
//             _drawerItem(
//                 DrawerItem.earnings, Iconsax.trend_up, 'Earnings Summary'),
//             _drawerItem(DrawerItem.analytics, Iconsax.chart_2, 'Analytics'),
//             _section('MANAGEMENT'),
//             _drawerItem(DrawerItem.complaints, Iconsax.warning_2, 'Complaints'),
//             _drawerItem(DrawerItem.tenants, Iconsax.people, 'Tenants List'),
//             _drawerItem(DrawerItem.calls, Iconsax.call, 'Call History'),
//             _section('ACCOUNT'),
//             _drawerItem(
//                 DrawerItem.profile, Iconsax.profile_circle, 'My Profile'),
//             _drawerItem(DrawerItem.notifications, Iconsax.notification,
//                 'Notifications'),
//             _drawerItem(DrawerItem.settings, Iconsax.setting_2, 'App Settings'),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Iconsax.logout, color: Colors.red),
//               title: const Text(
//                 'Logout',
//                 style: TextStyle(color: Colors.red),
//               ),
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

//   Widget _drawerItem(DrawerItem item, IconData icon, String title) {
//     final bool isActive = _activeDrawerItem == item;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(10),
//         onTap: () {
//           setState(() => _activeDrawerItem = item);
//           Navigator.pop(context);
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     const PaymentsScreen()), // Replace NewScreen with your target screen
//           );
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
//      CUSTOM BOTTOM NAV
//      ======================= */
//   Widget _buildBottomNavigation() {
//     return Container(
//       height: 78,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           top: BorderSide(color: Color(0xFFE5E7EB)),
//         ),
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
//       onTap: () {
//         setState(() {
//           _selectedIndex = index;
//         });
//       },
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
