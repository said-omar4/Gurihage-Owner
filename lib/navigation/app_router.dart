// // lib/navigation/app_router.dart
// import 'package:flutter/material.dart';
// import 'package:xirfadsan_receipt/features/auth/presentation/screens/splash_screen.dart';
// import 'package:xirfadsan_receipt/features/auth/presentation/screens/auth_screen.dart';
// import 'package:xirfadsan_receipt/features/dashboard/presentation/screens/dashboard_screen.dart';

// class AppRouter {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (_) => const DashboardScreen());
//       case '/splash':
//         return MaterialPageRoute(builder: (_) => const SplashScreen());
//       case '/auth':
//         return MaterialPageRoute(builder: (_) => const AuthScreen());
//       case '/dashboard':
//         return MaterialPageRoute(builder: (_) => const DashboardScreen());
//       // Add more routes as you create screens
//       default:
//         return MaterialPageRoute(
//           builder: (_) => Scaffold(
//             body: Center(
//               child: Text('No route defined for ${settings.name}'),
//             ),
//           ),
//         );
//     }
//   }
// }
