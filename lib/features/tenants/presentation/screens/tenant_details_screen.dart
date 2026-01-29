// lib/features/tenants/presentation/screens/tenant_details_screen.dart

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:xirfadsan_receipt/core/widgets/custom_appbar.dart';

class TenantDetailsScreen extends StatefulWidget {
  final String tenantId;
  final String tenantName;
  final String tenantEmail;
  final String tenantPhone;

  const TenantDetailsScreen({
    super.key,
    required this.tenantId,
    required this.tenantName,
    this.tenantEmail = '',
    this.tenantPhone = '',
  });

  @override
  State<TenantDetailsScreen> createState() => _TenantDetailsScreenState();
}

class _TenantDetailsScreenState extends State<TenantDetailsScreen> {
  final List<Map<String, dynamic>> _payments = [
    {
      'id': '1',
      'amount': 850,
      'date': '2024-03-15',
      'status': 'completed',
    },
    {
      'id': '2',
      'amount': 850,
      'date': '2024-02-15',
      'status': 'completed',
    },
    {
      'id': '3',
      'amount': 850,
      'date': '2024-01-15',
      'status': 'pending',
    },
  ];

  Map<String, dynamic> get _tenant => {
        'id': widget.tenantId,
        'full_name': widget.tenantName,
        'email': widget.tenantEmail,
        'phone': widget.tenantPhone,
        'move_in_date': '2024-01-10',
        'property': {
          'name': 'Studio Cozy Studio Near Park',
          'address': 'Banaadir mogadishu somalia',
        },
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tenant = _tenant;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: const CustomAppBar(
        title: 'Tenant Detail',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 8),

                // Tenant Profile Card
                _buildTenantProfileCard(theme, tenant),
                const SizedBox(height: 16),

                // Statistics
                _buildStatistics(theme),
                const SizedBox(height: 16),

                // Property Info
                _buildPropertyInfo(theme, tenant),
                const SizedBox(height: 16),

                // Payment History
                _buildPaymentHistory(theme),
                const SizedBox(height: 16),

                // Action Buttons
                _buildActionButtons(theme, tenant),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========== TENANT PROFILE CARD ==========
  Widget _buildTenantProfileCard(ThemeData theme, Map<String, dynamic> tenant) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerTheme.color ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(48),
                border: Border.all(
                  color: theme.primaryColor.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  tenant['full_name'][0],
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: theme.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Name
            Text(
              tenant['full_name'],
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),

            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                'Active Tenant',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: theme.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Divider
            Divider(
              height: 0,
              color: theme.dividerTheme.color,
            ),
            const SizedBox(height: 24),

            // Contact Info
            Column(
              children: [
                if (tenant['email'] != null && tenant['email'].isNotEmpty)
                  _buildContactItem(
                    theme: theme,
                    icon: Iconsax.sms,
                    label: 'Email',
                    value: tenant['email'],
                  ),
                if (tenant['phone'] != null && tenant['phone'].isNotEmpty)
                  _buildContactItem(
                    theme: theme,
                    icon: Iconsax.call,
                    label: 'Phone',
                    value: tenant['phone'],
                  ),
                if (tenant['move_in_date'] != null)
                  _buildContactItem(
                    theme: theme,
                    icon: Iconsax.calendar,
                    label: 'Move-in Date',
                    value: _formatDate(tenant['move_in_date']),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required ThemeData theme,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 20,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========== STATISTICS ==========
  Widget _buildStatistics(ThemeData theme) {
    final totalPaid = _payments
        .where((p) => p['status'] == 'completed')
        .fold<int>(0, (sum, p) => sum + (p['amount'] as int));

    final completedPayments =
        _payments.where((p) => p['status'] == 'completed').length;

    final tenancyMonths = 3; // Example value

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            theme: theme,
            icon: Iconsax.card,
            value: '\$$totalPaid',
            label: 'Total Paid',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            theme: theme,
            icon: Iconsax.user,
            value: '$tenancyMonths',
            label: 'Months',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            theme: theme,
            icon: Iconsax.calendar_1,
            value: '$completedPayments',
            label: 'Payments',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required ThemeData theme,
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerTheme.color ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.primaryColor,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.5),
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========== PROPERTY INFO ==========
  Widget _buildPropertyInfo(ThemeData theme, Map<String, dynamic> tenant) {
    if (tenant['property'] == null) return const SizedBox();

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerTheme.color ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PROPERTY',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
                fontSize: 11,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Iconsax.home_1,
                    size: 24,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tenant['property']['name'],
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Iconsax.location,
                            size: 16,
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              tenant['property']['address'],
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.6),
                                fontSize: 14,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ========== PAYMENT HISTORY ==========
  Widget _buildPaymentHistory(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerTheme.color ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RECENT PAYMENTS',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
                fontSize: 11,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),
            if (_payments.isEmpty)
              _buildEmptyPayments(theme)
            else
              Column(
                children: _payments.map((payment) {
                  return _buildPaymentItem(theme, payment);
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentItem(ThemeData theme, Map<String, dynamic> payment) {
    final isCompleted = payment['status'] == 'completed';
    final statusColor = isCompleted ? Colors.green : Colors.amber;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Iconsax.card,
              size: 20,
              color: statusColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${payment['amount']}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatDate(payment['date']),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: statusColor.withOpacity(0.3),
              ),
            ),
            child: Text(
              payment['status'].toString().toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: statusColor,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPayments(ThemeData theme) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Icon(
          Iconsax.card,
          size: 48,
          color: theme.colorScheme.onSurface.withOpacity(0.2),
        ),
        const SizedBox(height: 12),
        Text(
          'No payment history',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // ========== ACTION BUTTONS ==========
  Widget _buildActionButtons(ThemeData theme, Map<String, dynamic> tenant) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _onMessagePressed(tenant['id']),
            icon: Icon(
              Iconsax.message,
              size: 20,
              color: theme.primaryColor,
            ),
            label: Text(
              'Message',
              style: TextStyle(
                color: theme.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: theme.primaryColor,
                width: 1.5,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        if (tenant['phone'] != null && tenant['phone'].isNotEmpty) ...[
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _onCallPressed(tenant['phone']),
              icon: const Icon(
                Iconsax.call,
                size: 20,
                color: Colors.white,
              ),
              label: const Text(
                'Call',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ========== HELPER METHODS ==========
  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM d, yyyy').format(date);
    } catch (e) {
      return 'N/A';
    }
  }

  void _onMessagePressed(String tenantId) {
    print('Message tenant $tenantId');
  }

  void _onCallPressed(String phoneNumber) {
    print('Call $phoneNumber');
  }
}

// // lib/features/tenants/presentation/screens/tenant_details_screen.dart
// import 'package:flutter/material.dart';

// class TenantDetailsScreen extends StatefulWidget {
//   final String tenantId;
//   final String tenantName;
//   final String tenantEmail;
//   final String tenantPhone;

//   const TenantDetailsScreen({
//     super.key,
//     required this.tenantId,
//     required this.tenantName,
//     this.tenantEmail = '',
//     this.tenantPhone = '',
//   });

//   @override
//   State<TenantDetailsScreen> createState() => _TenantDetailsScreenState();
// }

// class _TenantDetailsScreenState extends State<TenantDetailsScreen> {
//   final List<Map<String, dynamic>> _payments = [
//     {
//       'id': '1',
//       'amount': 850,
//       'date': '2024-03-15',
//       'status': 'completed',
//     },
//     {
//       'id': '2',
//       'amount': 850,
//       'date': '2024-02-15',
//       'status': 'completed',
//     },
//     {
//       'id': '3',
//       'amount': 850,
//       'date': '2024-01-15',
//       'status': 'pending',
//     },
//   ];

//   Map<String, dynamic> get _tenant => {
//         'id': widget.tenantId,
//         'full_name': widget.tenantName,
//         'email': widget.tenantEmail,
//         'phone': widget.tenantPhone,
//         'move_in_date': '2024-01-10',
//         'property': {
//           'name': 'Studio Cozy Studio Near Park',
//           'address': 'Banaadir mogadishu somalia',
//         },
//       };

//   @override
//   Widget build(BuildContext context) {
//     final tenant = _tenant;

//     return Scaffold(
//       backgroundColor: const Color(0xFFFAFAFA),
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//         ),
//         title: const Text(
//           'Tenant Details',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Tenant Profile Card
//             _buildTenantProfileCard(tenant),
//             const SizedBox(height: 16),

//             // Statistics
//             _buildStatistics(),
//             const SizedBox(height: 16),

//             // Property Info
//             _buildPropertyInfo(tenant),
//             const SizedBox(height: 16),

//             // Payment History
//             _buildPaymentHistory(),
//             const SizedBox(height: 16),

//             // Action Buttons
//             _buildActionButtons(tenant),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   // ========== TENANT PROFILE CARD ==========
//   Widget _buildTenantProfileCard(Map<String, dynamic> tenant) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 0,
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           children: [
//             // Avatar
//             CircleAvatar(
//               radius: 48,
//               backgroundColor: const Color(0xFF22C55E).withOpacity(0.1),
//               child: Text(
//                 tenant['full_name'][0],
//                 style: const TextStyle(
//                   fontSize: 36,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF22C55E),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // Name
//             Text(
//               tenant['full_name'],
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 8),

//             // Status Badge
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF10B981).withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: const Color(0xFF10B981).withOpacity(0.3),
//                 ),
//               ),
//               child: const Text(
//                 'Active Tenant',
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF10B981),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Divider
//             Container(
//               height: 1,
//               color: Colors.grey.shade200,
//             ),
//             const SizedBox(height: 24),

//             // Contact Info
//             Column(
//               children: [
//                 if (tenant['email'] != null && tenant['email'].isNotEmpty)
//                   _buildContactItem(
//                     icon: Icons.email_outlined,
//                     label: 'Email',
//                     value: tenant['email'],
//                   ),
//                 if (tenant['phone'] != null && tenant['phone'].isNotEmpty)
//                   _buildContactItem(
//                     icon: Icons.phone_outlined,
//                     label: 'Phone',
//                     value: tenant['phone'],
//                   ),
//                 if (tenant['move_in_date'] != null)
//                   _buildContactItem(
//                     icon: Icons.calendar_today_outlined,
//                     label: 'Move-in Date',
//                     value: _formatDate(tenant['move_in_date']),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContactItem({
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: const Color(0xFF22C55E).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Icon(
//               icon,
//               size: 20,
//               color: const Color(0xFF22C55E),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ========== STATISTICS ==========
//   Widget _buildStatistics() {
//     final totalPaid = _payments
//         .where((p) => p['status'] == 'completed')
//         .fold<int>(0, (sum, p) => sum + (p['amount'] as int));

//     final completedPayments =
//         _payments.where((p) => p['status'] == 'completed').length;

//     final tenancyMonths = 3; // Example value

//     return Row(
//       children: [
//         Expanded(
//           child: _buildStatCard(
//             icon: Icons.credit_card_outlined,
//             value: '\$$totalPaid',
//             label: 'Total Paid',
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: _buildStatCard(
//             icon: Icons.person_outline,
//             value: '$tenancyMonths',
//             label: 'Months',
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: _buildStatCard(
//             icon: Icons.calendar_today_outlined,
//             value: '$completedPayments',
//             label: 'Payments',
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatCard({
//     required IconData icon,
//     required String value,
//     required String label,
//   }) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       elevation: 0,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Icon(
//               icon,
//               size: 24,
//               color: const Color(0xFF22C55E),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700,
//                 color: Color(0xFF22C55E),
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ========== PROPERTY INFO ==========
//   Widget _buildPropertyInfo(Map<String, dynamic> tenant) {
//     if (tenant['property'] == null) return const SizedBox();

//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 0,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'PROPERTY',
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey,
//                 letterSpacing: 1,
//               ),
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Container(
//                   width: 48,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF22C55E).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.apartment_outlined,
//                     size: 24,
//                     color: Color(0xFF22C55E),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         tenant['property']['name'],
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.location_on_outlined,
//                             size: 14,
//                             color: Colors.grey,
//                           ),
//                           const SizedBox(width: 4),
//                           Expanded(
//                             child: Text(
//                               tenant['property']['address'],
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ========== PAYMENT HISTORY ==========
//   Widget _buildPaymentHistory() {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 0,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'RECENT PAYMENTS',
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.grey,
//                 letterSpacing: 1,
//               ),
//             ),
//             const SizedBox(height: 12),
//             if (_payments.isEmpty)
//               _buildEmptyPayments()
//             else
//               Column(
//                 children: _payments.map((payment) {
//                   return _buildPaymentItem(payment);
//                 }).toList(),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPaymentItem(Map<String, dynamic> payment) {
//     final isCompleted = payment['status'] == 'completed';

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: isCompleted
//                   ? const Color(0xFF10B981).withOpacity(0.1)
//                   : const Color(0xFFF59E0B).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Icon(
//               Icons.credit_card_outlined,
//               size: 20,
//               color: isCompleted
//                   ? const Color(0xFF10B981)
//                   : const Color(0xFFF59E0B),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '\$${payment['amount']}',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   _formatDate(payment['date']),
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//             decoration: BoxDecoration(
//               color: isCompleted
//                   ? const Color(0xFF10B981).withOpacity(0.1)
//                   : const Color(0xFFF59E0B).withOpacity(0.1),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(
//                 color: isCompleted
//                     ? const Color(0xFF10B981).withOpacity(0.3)
//                     : const Color(0xFFF59E0B).withOpacity(0.3),
//               ),
//             ),
//             child: Text(
//               payment['status'],
//               style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w600,
//                 color: isCompleted
//                     ? const Color(0xFF10B981)
//                     : const Color(0xFFF59E0B),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyPayments() {
//     return Column(
//       children: [
//         const SizedBox(height: 20),
//         Icon(
//           Icons.credit_card_outlined,
//           size: 48,
//           color: Colors.grey.shade400,
//         ),
//         const SizedBox(height: 12),
//         const Text(
//           'No payment history',
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//           ),
//         ),
//         const SizedBox(height: 20),
//       ],
//     );
//   }

//   // ========== ACTION BUTTONS ==========
//   Widget _buildActionButtons(Map<String, dynamic> tenant) {
//     return Row(
//       children: [
//         Expanded(
//           child: OutlinedButton.icon(
//             onPressed: () => _onMessagePressed(tenant['id']),
//             icon: const Icon(Icons.message_outlined, size: 20),
//             label: const Text('Message'),
//             style: OutlinedButton.styleFrom(
//               foregroundColor: const Color(0xFF22C55E),
//               side: const BorderSide(color: Color(0xFF22C55E)),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),
//         if (tenant['phone'] != null && tenant['phone'].isNotEmpty) ...[
//           const SizedBox(width: 12),
//           Expanded(
//             child: ElevatedButton.icon(
//               onPressed: () => _onCallPressed(tenant['phone']),
//               icon: const Icon(Icons.phone_outlined, size: 20),
//               label: const Text('Call'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF22C55E),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ],
//     );
//   }

//   // ========== HELPER METHODS ==========
//   String _formatDate(String dateString) {
//     try {
//       final date = DateTime.parse(dateString);
//       final monthNames = [
//         'Jan',
//         'Feb',
//         'Mar',
//         'Apr',
//         'May',
//         'Jun',
//         'Jul',
//         'Aug',
//         'Sep',
//         'Oct',
//         'Nov',
//         'Dec'
//       ];
//       return '${monthNames[date.month - 1]} ${date.day}, ${date.year}';
//     } catch (e) {
//       return 'N/A';
//     }
//   }

//   void _onMessagePressed(String tenantId) {
//     print('Message tenant $tenantId');
//   }

//   void _onCallPressed(String phoneNumber) {
//     print('Call $phoneNumber');
//   }
// }
