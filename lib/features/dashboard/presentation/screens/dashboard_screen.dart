// // lib/features/dashboard/presentation/screens/dashboard_screen.dart
// import 'package:flutter/material.dart';

// class DashboardScreen extends StatelessWidget {
//   final Function(int)? onNavigate;
//   const DashboardScreen({super.key, this.onNavigate});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ================= STATS GRID =================
//             GridView.count(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisCount: 2,
//               mainAxisSpacing: 12,
//               crossAxisSpacing: 12,
//               childAspectRatio: 1.2,
//               children: [
//                 _buildStatCard(
//                   value: '25',
//                   label: 'Total Properties',
//                   icon: Icons.home_outlined,
//                 ),
//                 _buildStatCard(
//                   value: '30',
//                   label: 'Active Tenants',
//                   icon: Icons.people_outlined,
//                 ),
//                 _buildStatCard(
//                   value: '120',
//                   label: 'Monthly Earning',
//                   icon: Icons.trending_up_outlined,
//                 ),
//                 _buildStatCard(
//                   value: '50',
//                   label: 'Pending Booking',
//                   icon: Icons.calendar_today_outlined,
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // ================= QUICK ACTIONS =================
//             const Text(
//               'Quick Actions',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 16),

//             GridView.count(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisCount: 2,
//               mainAxisSpacing: 12,
//               crossAxisSpacing: 12,
//               childAspectRatio: 1.5,
//               children: [
//                 _quickAction(
//                   context,
//                   icon: Icons.apartment_outlined,
//                   label: 'Properties',
//                 ),
//                 _quickAction(
//                   context,
//                   icon: Icons.calendar_month_outlined,
//                   label: 'Booking',
//                 ),
//                 _quickAction(
//                   context,
//                   icon: Icons.report_problem_outlined,
//                   label: 'Complaints',
//                 ),
//                 _quickAction(
//                   context,
//                   icon: Icons.message_outlined,
//                   label: 'Messages',
//                 ),
//                 _quickAction(
//                   context,
//                   icon: Icons.attach_money_outlined,
//                   label: 'Earning',
//                 ),
//                 _quickAction(
//                   context,
//                   icon: Icons.people_alt_outlined,
//                   label: 'Tenants',
//                 ),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // ================= RECENT ACTIVITY =================
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Recent Activity',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'See All',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Color(0xFF22C55E),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),

//             Card(
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16),
//                 side: BorderSide(
//                   color: Colors.grey.shade200,
//                 ),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 32),
//                 child: Center(
//                   child: Text(
//                     'No recent activity',
//                     style: TextStyle(
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= STAT CARD =================
//   Widget _buildStatCard({
//     required String value,
//     required String label,
//     required IconData icon,
//   }) {
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(
//           color: Colors.grey.shade200,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF22C55E),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   label,
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF22C55E).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 icon,
//                 color: const Color(0xFF22C55E),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ================= QUICK ACTION BUTTON =================
//   Widget _quickAction(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//   }) {
//     return ElevatedButton(
//       onPressed: () => _navigate(label),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF22C55E),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         elevation: 0,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 28, color: Colors.white),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: const TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }

//   // ================= NAVIGATION =================
//   void _navigate(String label) {
//     switch (label) {
//       case 'Properties':
//         onNavigate?.call(1);
//         break;
//       case 'Booking':
//         onNavigate?.call(2);
//         break;
//       case 'Messages':
//         onNavigate?.call(3);
//         break;
//       case 'Complaints':
//         onNavigate?.call(5);
//         break;
//       case 'Earning':
//         onNavigate?.call(6);
//         break;
//       case 'Tenants':
//         onNavigate?.call(7);
//         break;
//     }
//   }
// }

///////////////////////////

// lib/features/dashboard/presentation/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:xirfadsan_receipt/appbar.dart';
import 'package:xirfadsan_receipt/features/Earning/earning_screen.dart';
import 'package:xirfadsan_receipt/features/Tenant%20List/tenant_list.dart';
import 'package:xirfadsan_receipt/features/bookings/presentation/screens/bookings_screen.dart';
import 'package:xirfadsan_receipt/features/chats/presentation/screens/chats_screen.dart';
import 'package:xirfadsan_receipt/features/complaint/complaint.dart';
import 'package:xirfadsan_receipt/features/properties/presentation/screens/properties_screen.dart';

class DashboardScreen extends StatelessWidget {
  final Function(int)? onNavigate;
  const DashboardScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Grid - 2x2
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
                children: [
                  _buildStatCard(
                    value: '25',
                    label: 'Total Properties',
                    icon: Icons.home_outlined,
                  ),
                  _buildStatCard(
                    value: '30',
                    label: 'Active Tenants',
                    icon: Icons.people_outlined,
                  ),
                  _buildStatCard(
                    value: '120',
                    label: 'Monthly Earning',
                    icon: Icons.trending_up_outlined,
                  ),
                  _buildStatCard(
                    value: '50',
                    label: 'Pending Booking',
                    icon: Icons.calendar_today_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Quick Actions Title
              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // Quick Actions Grid - 2x3
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  _buildQuickActionButton(
                    context: context,
                    icon: Icons.apartment_outlined,
                    label: 'Properties',
                  ),
                  _buildQuickActionButton(
                    context: context,
                    icon: Icons.calendar_month_outlined,
                    label: 'Booking',
                  ),
                  _buildQuickActionButton(
                    context: context,
                    icon: Icons.report_problem_outlined,
                    label: 'Complaints',
                  ),
                  _buildQuickActionButton(
                    context: context,
                    icon: Icons.message_outlined,
                    label: 'Messages',
                  ),
                  _buildQuickActionButton(
                    context: context,
                    icon: Icons.attach_money_outlined,
                    label: 'Earning',
                  ),
                  _buildQuickActionButton(
                    context: context,
                    icon: Icons.people_alt_outlined,
                    label: 'Tenants',
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Recent Activity Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                    ),
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF22C55E),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Recent Activity Card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: Colors.grey.shade200,
                    width: 1,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text(
                      'No recent activity',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========== HELPER METHODS ==========

  // Stat Card Builder
  Widget _buildStatCard({
    required String value,
    required String label,
    required IconData icon,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF22C55E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 22,
                    color: const Color(0xFF22C55E),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, String label) {
    switch (label) {
      case 'Properties':
        onNavigate?.call(1);
        break;
      case 'Booking':
        onNavigate?.call(2);
        break;
      case 'Messages':
        onNavigate?.call(3);
        break;
      case 'Profile':
        onNavigate?.call(4);
        break;
      case 'Complaints':
        onNavigate?.call(5);
        break;
      case 'Earning':
        onNavigate?.call(6);
        break;
      case 'Tenants':
        onNavigate?.call(7);
        break;
    }
  }

  // Quick Action Button Builder
  Widget _buildQuickActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
  }) {
    return ElevatedButton(
      onPressed: () {
        _navigateToScreen(context, label);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF22C55E),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        elevation: 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
