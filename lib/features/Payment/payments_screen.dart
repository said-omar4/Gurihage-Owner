// lib/presentation/screens/payments_screen.dart
import 'package:flutter/material.dart';
import 'package:xirfadsan_receipt/appbar.dart';

// ============================================
// PAYMENT MODEL
// ============================================
class Payment {
  final int id;
  final String method;
  final String date;
  final String status;
  final String tenantName;
  final String tenantAvatar;
  final String property;
  final double amount;

  const Payment({
    required this.id,
    required this.method,
    required this.date,
    required this.status,
    required this.tenantName,
    required this.tenantAvatar,
    required this.property,
    required this.amount,
  });
}

// ============================================
// PAYMENTS SCREEN
// ============================================
class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Payment data
  final List<Payment> _payments = [
    const Payment(
      id: 1,
      method: "Evc plus",
      date: "2024-01-15",
      status: "completed",
      tenantName: "Said-omar ahmed",
      tenantAvatar: "https://api.dicebear.com/7.x/avataaars/svg?seed=tenant1",
      property: "Dahab Tower",
      amount: 2095,
    ),
    const Payment(
      id: 2,
      method: "MasterCard",
      date: "2024-01-15",
      status: "completed",
      tenantName: "Said-omar ahmed",
      tenantAvatar: "https://api.dicebear.com/7.x/avataaars/svg?seed=tenant2",
      property: "Dahab Tower",
      amount: 2095,
    ),
    const Payment(
      id: 3,
      method: "eDahab",
      date: "2024-01-15",
      status: "completed",
      tenantName: "Said-omar ahmed",
      tenantAvatar: "https://api.dicebear.com/7.x/avataaars/svg?seed=tenant3",
      property: "Dahab Tower",
      amount: 2095,
    ),
  ];

  // Colors for payment methods
  Map<String, Map<String, Color>> get methodColors => {
        'Evc plus': {
          'background': const Color(0xFFDCFCE7),
          'text': const Color(0xFF166534),
          'border': const Color(0xFF86EFAC),
        },
        'MasterCard': {
          'background': const Color(0xFFFEE2E2),
          'text': const Color(0xFF991B1B),
          'border': const Color(0xFFFCA5A5),
        },
        'eDahab': {
          'background': const Color(0xFFFFEDD5),
          'text': const Color(0xFF9A3412),
          'border': const Color(0xFFFDBA74),
        },
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar (like your other screens)
            // _buildAppBar(),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Search Bar
                    _buildSearchBar(),
                    const SizedBox(height: 20),

                    // Payments List
                    _buildPaymentsList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // AppBar Widget
  // Widget _buildAppBar() {
  //   return Container(
  //     color: const Color(0xFFFAFAFA),
  //     padding: const EdgeInsets.only(
  //       top: 40,
  //       left: 16,
  //       right: 16,
  //       bottom: 16,
  //     ),
  //     child: Row(
  //       children: [
  //         Container(
  //           width: 40,
  //           height: 40,
  //           decoration: BoxDecoration(
  //             color: const Color(0xFF22C55E),
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: const Icon(
  //             Icons.person,
  //             color: Colors.white,
  //             size: 24,
  //           ),
  //         ),
  //         const SizedBox(width: 12),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 children: [
  //                   const Icon(
  //                     Icons.location_on,
  //                     color: Color(0xFF22C55E),
  //                     size: 16,
  //                   ),
  //                   const SizedBox(width: 4),
  //                   const Text(
  //                     'Bnadir, Mogadishu',
  //                     style: TextStyle(
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.w600,
  //                       fontFamily: 'Poppins',
  //                       color: Color(0xFF1A1A1A),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 4),
  //                   Icon(
  //                     Icons.keyboard_arrow_down,
  //                     color: Colors.grey[400],
  //                     size: 16,
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 4),
  //               const Text(
  //                 'Search payments..',
  //                 style: TextStyle(
  //                   fontSize: 12,
  //                   fontFamily: 'Poppins',
  //                   color: Color(0xFF737373),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(width: 12),
  //         Container(
  //           width: 40,
  //           height: 40,
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(
  //               color: const Color(0xFFE5E5E7),
  //             ),
  //           ),
  //           child: const Icon(
  //             Icons.notifications_none,
  //             color: Color(0xFF1A1A1A),
  //             size: 24,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Search Bar Widget
  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E7)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(
            Icons.search,
            color: Color(0xFF737373),
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search payments..',
                hintStyle: TextStyle(
                  color: Color(0xFF737373),
                  fontFamily: 'Poppins',
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, size: 20),
            color: const Color(0xFF22C55E),
            onPressed: () {
              // Handle filter
            },
          ),
        ],
      ),
    );
  }

  // Payments List Widget
  Widget _buildPaymentsList() {
    return Column(
      children: _payments.map((payment) => _buildPaymentCard(payment)).toList(),
    );
  }

  // Single Payment Card Widget
  Widget _buildPaymentCard(Payment payment) {
    final methodColor =
        methodColors[payment.method] ?? methodColors['Evc plus']!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E7)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Top Row: Method, Date, Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Payment Method Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: methodColor['background'],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: methodColor['border']!),
                  ),
                  child: Text(
                    payment.method,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: methodColor['text'],
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),

                // Date
                Text(
                  payment.date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF737373),
                    fontFamily: 'Poppins',
                  ),
                ),

                // Status Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF86EFAC)),
                  ),
                  child: Text(
                    payment.status,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF166534),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Tenant Info Row
            Row(
              children: [
                // Tenant Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE5E5E7)),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      payment.tenantAvatar,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFFF5F5F5),
                        child: Center(
                          child: Text(
                            payment.tenantName[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF737373),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Tenant Name and Property
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        payment.tenantName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        payment.property,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF737373),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),

                // Chevron Icon
                const Icon(
                  Icons.chevron_right,
                  size: 24,
                  color: Color(0xFF737373),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Bottom Row: Amount and Receipt Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Amount
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF737373),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${payment.amount.toStringAsFixed(0)} USD',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF22C55E),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),

                // Receipt Button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF22C55E)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Navigate to receipt
                        print('View receipt for payment ${payment.id}');
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.download,
                              size: 18,
                              color: Color(0xFF22C55E),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Receipt',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF22C55E),
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
