import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:xirfadsan_receipt/features/Analytics/Analytics_screen.dart';
import 'package:xirfadsan_receipt/features/App Setting/app_setting.dart';
import 'package:xirfadsan_receipt/features/Earning/earning_screen.dart';
import 'package:xirfadsan_receipt/features/Payment/payments_screen.dart';
import 'package:xirfadsan_receipt/features/Tenant List/tenant_list.dart';
import 'package:xirfadsan_receipt/features/bookings/presentation/screens/bookings_screen.dart';
import 'package:xirfadsan_receipt/features/call history/call_history.dart';
import 'package:xirfadsan_receipt/features/chats/presentation/screens/chats_screen.dart';
import 'package:xirfadsan_receipt/features/complaint/complaint.dart';
import 'package:xirfadsan_receipt/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:xirfadsan_receipt/features/profile/presentation/screens/notifications.dart';
import 'package:xirfadsan_receipt/features/profile/presentation/screens/profile_screen.dart';
import 'package:xirfadsan_receipt/features/properties/presentation/screens/properties_screen.dart';

enum DrawerItem {
  dashboard,
  properties,
  bookings,
  chats,
  payments,
  earnings,
  analytics,
  complaints,
  tenants,
  calls,
  profile,
  notifications,
  settings,
}

Widget getScreen(DrawerItem item) {
  switch (item) {
    case DrawerItem.dashboard:
      return const DashboardScreen();
    case DrawerItem.properties:
      return const PropertiesScreen();
    case DrawerItem.bookings:
      return const BookingsScreen();
    case DrawerItem.chats:
      return const ChatsScreen();
    case DrawerItem.payments:
      return const PaymentsScreen();
    case DrawerItem.earnings:
      return const EarningsScreen();
    case DrawerItem.analytics:
      return const AnalyticsScreen();
    case DrawerItem.complaints:
      return const ComplaintsScreen();
    case DrawerItem.tenants:
      return const TenantsScreen();
    case DrawerItem.calls:
      return const CallHistoryScreen();
    case DrawerItem.profile:
      return const ProfileScreen();
    case DrawerItem.notifications:
      return const NotificationsScreen();
    case DrawerItem.settings:
      return const SettingsScreen();
    default:
      return const DashboardScreen();
  }
}

class CustomAppBar {
  static AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      title: const Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/avatar.png'),
          ),
          SizedBox(width: 8),
          Text(
            'Bnadir, Mogadishu',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          SizedBox(width: 4),
          Icon(Iconsax.arrow_down_1, size: 18),
        ],
      ),
      actions: const [
        Icon(Iconsax.notification, color: Colors.black),
        SizedBox(width: 12),
      ],
    );
  }

  static Drawer buildDrawer(BuildContext context, DrawerItem activeDrawerItem,
      Function(DrawerItem) onTap) {
    Widget section(String title) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 0, 6),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      );
    }

    Widget drawerItem(DrawerItem item, IconData icon, String title) {
      final bool isActive = activeDrawerItem == item;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.pop(context); // ✅ CLOSE DRAWER
            onTap(item); // ✅ CALL MAIN NAVIGATION
          },
          child: Container(
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF22C55E) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              dense: true,
              leading: Icon(
                icon,
                size: 20,
                color: isActive ? Colors.white : Colors.black87,
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: isActive ? Colors.white : Colors.black87,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget drawerHeader() {
      return ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage('assets/avatar.png'),
        ),
        title: const Text('Bnadir Mogadishu'),
        subtitle: const Text('Owner'),
        trailing: const Icon(Iconsax.close_circle),
        onTap: () => Navigator.pop(context),
      );
    }

    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            drawerHeader(),
            section('MAIN'),
            drawerItem(DrawerItem.dashboard, Iconsax.home_2, 'Dashboard'),
            drawerItem(
                DrawerItem.properties, Iconsax.buildings, 'My Properties'),
            drawerItem(DrawerItem.bookings, Iconsax.calendar_1, 'My Bookings'),
            drawerItem(DrawerItem.chats, Iconsax.messages_2, 'My Chats'),
            section('FINANCE'),
            drawerItem(DrawerItem.payments, Iconsax.card, 'Payments'),
            drawerItem(
                DrawerItem.earnings, Iconsax.trend_up, 'Earnings Summary'),
            drawerItem(DrawerItem.analytics, Iconsax.chart_2, 'Analytics'),
            section('MANAGEMENT'),
            drawerItem(DrawerItem.complaints, Iconsax.warning_2, 'Complaints'),
            drawerItem(DrawerItem.tenants, Iconsax.people, 'Tenants List'),
            drawerItem(DrawerItem.calls, Iconsax.call, 'Call History'),
            section('ACCOUNT'),
            drawerItem(
                DrawerItem.profile, Iconsax.profile_circle, 'My Profile'),
            drawerItem(DrawerItem.notifications, Iconsax.notification,
                'Notifications'),
            drawerItem(DrawerItem.settings, Iconsax.setting_2, 'App Settings'),
            const Divider(),
            ListTile(
              leading: const Icon(Iconsax.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}







///////////////////////////////////////////////



// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:xirfadsan_receipt/features/Analytics/Analytics_screen.dart';
// import 'package:xirfadsan_receipt/features/App Setting/app_setting.dart';
// import 'package:xirfadsan_receipt/features/Earning/earning_screen.dart';
// import 'package:xirfadsan_receipt/features/Payment/payments_screen.dart';
// import 'package:xirfadsan_receipt/features/Tenant List/tenant_list.dart';
// import 'package:xirfadsan_receipt/features/bookings/presentation/screens/bookings_screen.dart';
// import 'package:xirfadsan_receipt/features/call history/call_history.dart';
// import 'package:xirfadsan_receipt/features/chats/presentation/screens/chats_screen.dart';
// import 'package:xirfadsan_receipt/features/complaint/complaint.dart';
// import 'package:xirfadsan_receipt/features/dashboard/presentation/screens/dashboard_screen.dart';
// import 'package:xirfadsan_receipt/features/profile/presentation/screens/notifications.dart';
// import 'package:xirfadsan_receipt/features/profile/presentation/screens/profile_screen.dart';
// import 'package:xirfadsan_receipt/features/properties/presentation/screens/properties_screen.dart';

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

// Widget getScreen(DrawerItem item) {
//   switch (item) {
//     case DrawerItem.dashboard:
//       return const DashboardScreen();
//     case DrawerItem.properties:
//       return const PropertiesScreen();
//     case DrawerItem.bookings:
//       return const BookingsScreen();
//     case DrawerItem.chats:
//       return const ChatsScreen();
//     case DrawerItem.payments:
//       return const PaymentsScreen();
//     case DrawerItem.earnings:
//       return const EarningsScreen();
//     case DrawerItem.analytics:
//       return const AnalyticsScreen();
//     case DrawerItem.complaints:
//       return const ComplaintsScreen();
//     case DrawerItem.tenants:
//       return const TenantsScreen();
//     case DrawerItem.calls:
//       return const CallHistoryScreen();
//     case DrawerItem.profile:
//       return const ProfileScreen();
//     case DrawerItem.notifications:
//       return const NotificationsScreen();
//     case DrawerItem.settings:
//       return const SettingsScreen();
//     default:
//       return const DashboardScreen();
//   }
// }

// class CustomAppBar {
//   static AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       iconTheme: const IconThemeData(color: Colors.black),
//       title: const Row(
//         children: [
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

//   static Drawer buildDrawer(BuildContext context, DrawerItem activeDrawerItem,
//       Function(DrawerItem) onTap) {
//     Widget section(String title) {
//       return Padding(
//         padding: const EdgeInsets.fromLTRB(16, 18, 0, 6),
//         child: Text(
//           title,
//           style: const TextStyle(
//             fontSize: 11,
//             fontWeight: FontWeight.w600,
//             color: Colors.grey,
//           ),
//         ),
//       );
//     }

//     Widget drawerItem(DrawerItem item, IconData icon, String title) {
//       final bool isActive = activeDrawerItem == item;

//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(10),
//           onTap: () {
//             Navigator.pop(context);
//             onTap(item); // ✅ ONLY THIS
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: isActive ? const Color(0xFF22C55E) : Colors.transparent,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: ListTile(
//               dense: true,
//               leading: Icon(
//                 icon,
//                 size: 20,
//                 color: isActive ? Colors.white : Colors.black87,
//               ),
//               title: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: isActive ? Colors.white : Colors.black87,
//                   fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     Widget drawerHeader() {
//       return ListTile(
//         leading: const CircleAvatar(
//           backgroundImage: AssetImage('assets/avatar.png'),
//         ),
//         title: const Text('Bnadir Mogadishu'),
//         subtitle: const Text('Owner'),
//         trailing: const Icon(Iconsax.close_circle),
//         onTap: () => Navigator.pop(context),
//       );
//     }

//     return Drawer(
//       child: SafeArea(
//         child: ListView(
//           children: [
//             drawerHeader(),
//             section('MAIN'),
//             drawerItem(DrawerItem.dashboard, Iconsax.home_2, 'Dashboard'),
//             drawerItem(
//                 DrawerItem.properties, Iconsax.buildings, 'My Properties'),
//             drawerItem(DrawerItem.bookings, Iconsax.calendar_1, 'My Bookings'),
//             drawerItem(DrawerItem.chats, Iconsax.messages_2, 'My Chats'),
//             section('FINANCE'),
//             drawerItem(DrawerItem.payments, Iconsax.card, 'Payments'),
//             drawerItem(
//                 DrawerItem.earnings, Iconsax.trend_up, 'Earnings Summary'),
//             drawerItem(DrawerItem.analytics, Iconsax.chart_2, 'Analytics'),
//             section('MANAGEMENT'),
//             drawerItem(DrawerItem.complaints, Iconsax.warning_2, 'Complaints'),
//             drawerItem(DrawerItem.tenants, Iconsax.people, 'Tenants List'),
//             drawerItem(DrawerItem.calls, Iconsax.call, 'Call History'),
//             section('ACCOUNT'),
//             drawerItem(
//                 DrawerItem.profile, Iconsax.profile_circle, 'My Profile'),
//             drawerItem(DrawerItem.notifications, Iconsax.notification,
//                 'Notifications'),
//             drawerItem(DrawerItem.settings, Iconsax.setting_2, 'App Settings'),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Iconsax.logout, color: Colors.red),
//               title: const Text('Logout', style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:xirfadsan_receipt/features/Analytics/Analytics_screen.dart';
// import 'package:xirfadsan_receipt/features/App%20Setting/app_setting.dart';
// import 'package:xirfadsan_receipt/features/Earning/earning_screen.dart';
// import 'package:xirfadsan_receipt/features/Payment/payments_screen.dart';
// import 'package:xirfadsan_receipt/features/Tenant%20List/tenant_list.dart';
// import 'package:xirfadsan_receipt/features/bookings/presentation/screens/bookings_screen.dart';
// import 'package:xirfadsan_receipt/features/call%20history/call_history.dart';
// import 'package:xirfadsan_receipt/features/chats/presentation/screens/chats_screen.dart';
// import 'package:xirfadsan_receipt/features/complaint/complaint.dart';
// import 'package:xirfadsan_receipt/features/dashboard/presentation/screens/dashboard_screen.dart';
// import 'package:xirfadsan_receipt/features/profile/presentation/screens/notifications.dart';
// import 'package:xirfadsan_receipt/features/profile/presentation/screens/profile_screen.dart';
// import 'package:xirfadsan_receipt/features/properties/presentation/screens/properties_screen.dart';

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

// Widget getScreen(DrawerItem item) {
//   switch (item) {
//     case DrawerItem.dashboard:
//       return const DashboardScreen();
//     case DrawerItem.properties:
//       return const PropertiesScreen();
//     case DrawerItem.bookings:
//       return const BookingsScreen();
//     case DrawerItem.chats:
//       return const ChatsScreen();
//     case DrawerItem.payments:
//       return const PaymentsScreen();
//     case DrawerItem.earnings:
//       return const EarningsScreen();
//     case DrawerItem.analytics:
//       return const AnalyticsScreen();
//     case DrawerItem.complaints:
//       return const ComplaintsScreen();
//     case DrawerItem.tenants:
//       return const TenantsScreen();
//     case DrawerItem.calls:
//       return const CallHistoryScreen();
//     case DrawerItem.profile:
//       return const ProfileScreen();
//     case DrawerItem.notifications:
//       return const NotificationsScreen();
//     case DrawerItem.settings:
//       return const SettingsScreen();
//     default:
//       return const DashboardScreen();
//   }
// }

// class CustomAppBar {
//   static AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       iconTheme: const IconThemeData(color: Colors.black),
//       title: const Row(
//         children: [
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

//   static Drawer buildDrawer(BuildContext context, DrawerItem activeDrawerItem,
//       Function(DrawerItem) onTap) {
//     Widget section(String title) {
//       return Padding(
//         padding: const EdgeInsets.fromLTRB(16, 18, 0, 6),
//         child: Text(
//           title,
//           style: const TextStyle(
//             fontSize: 11,
//             fontWeight: FontWeight.w600,
//             color: Colors.grey,
//           ),
//         ),
//       );
//     }

//     Widget drawerItem(DrawerItem item, IconData icon, String title) {
//       final bool isActive = activeDrawerItem == item;
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(10),
//           onTap: () {
//             onTap(item);
//             Navigator.pop(context);
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => getScreen(item)),
//             );
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: isActive ? const Color(0xFF22C55E) : Colors.transparent,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: ListTile(
//               dense: true,
//               leading: Icon(
//                 icon,
//                 size: 20,
//                 color: isActive ? Colors.white : Colors.black87,
//               ),
//               title: Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: isActive ? Colors.white : Colors.black87,
//                   fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     Widget drawerHeader() {
//       return ListTile(
//         leading: const CircleAvatar(
//           backgroundImage: AssetImage('assets/avatar.png'),
//         ),
//         title: const Text('Bnadir Mogadishu'),
//         subtitle: const Text('Owner'),
//         trailing: const Icon(Iconsax.close_circle),
//         onTap: () => Navigator.pop(context),
//       );
//     }

//     return Drawer(
//       child: SafeArea(
//         child: ListView(
//           children: [
//             drawerHeader(),
//             section('MAIN'),
//             drawerItem(DrawerItem.dashboard, Iconsax.home_2, 'Dashboard'),
//             drawerItem(
//                 DrawerItem.properties, Iconsax.buildings, 'My Properties'),
//             drawerItem(DrawerItem.bookings, Iconsax.calendar_1, 'My Bookings'),
//             drawerItem(DrawerItem.chats, Iconsax.messages_2, 'My Chats'),
//             section('FINANCE'),
//             drawerItem(DrawerItem.payments, Iconsax.card, 'Payments'),
//             drawerItem(
//               DrawerItem.earnings,
//               Iconsax.trend_up,
//               'Earnings Summary',
//             ),
//             drawerItem(DrawerItem.analytics, Iconsax.chart_2, 'Analytics'),
//             section('MANAGEMENT'),
//             drawerItem(DrawerItem.complaints, Iconsax.warning_2, 'Complaints'),
//             drawerItem(DrawerItem.tenants, Iconsax.people, 'Tenants List'),
//             drawerItem(DrawerItem.calls, Iconsax.call, 'Call History'),
//             section('ACCOUNT'),
//             drawerItem(
//                 DrawerItem.profile, Iconsax.profile_circle, 'My Profile'),
//             drawerItem(DrawerItem.notifications, Iconsax.notification,
//                 'Notifications'),
//             drawerItem(DrawerItem.settings, Iconsax.setting_2, 'App Settings'),
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
// }
