// lib/presentation/screens/tenant_details.dart
import 'package:flutter/material.dart';
import 'package:xirfadsan_receipt/appbar.dart';

// ============================================
// DATA MODELS
// ============================================
class TenantDetail {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String moveInDate;
  final String propertyName;
  final String propertyAddress;
  final String propertyId;
  final double monthlyRent;
  final String status;

  const TenantDetail({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.moveInDate,
    required this.propertyName,
    required this.propertyAddress,
    required this.propertyId,
    required this.monthlyRent,
    required this.status,
  });
}

class Payment {
  final String id;
  final double amount;
  final String paymentMethod;
  final String status;
  final String transactionDate;
  final String description;

  const Payment({
    required this.id,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    required this.transactionDate,
    required this.description,
  });
}

// ============================================
// TENANT DETAILS SCREEN
// ============================================
class TenantDetailsScreen extends StatefulWidget {
  final String tenantId;

  const TenantDetailsScreen({super.key, required this.tenantId});

  @override
  State<TenantDetailsScreen> createState() => _TenantDetailsScreenState();
}

class _TenantDetailsScreenState extends State<TenantDetailsScreen> {
  bool _isLoading = false;
  bool _showAddTransaction = false;
  DrawerItem _activeDrawerItem = DrawerItem.tenants;

  // Tenant data
  final TenantDetail _tenant = const TenantDetail(
    id: "1",
    fullName: "Said-omar ahmed",
    email: "said.omar@example.com",
    phone: "+252 614465608",
    moveInDate: "2024-01-15",
    propertyName: "Dahab Tower",
    propertyAddress: "Banaadir, Mogadishu Somalia",
    propertyId: "P001",
    monthlyRent: 2095,
    status: "Active",
  );

  // Payment history
  final List<Payment> _payments = [
    const Payment(
      id: "1",
      amount: 2095,
      paymentMethod: "Evc plus",
      status: "completed",
      transactionDate: "2024-03-01",
      description: "Rent payment for March",
    ),
    const Payment(
      id: "2",
      amount: 2095,
      paymentMethod: "eDahab",
      status: "completed",
      transactionDate: "2024-02-01",
      description: "Rent payment for February",
    ),
    const Payment(
      id: "3",
      amount: 2095,
      paymentMethod: "MasterCard",
      status: "completed",
      transactionDate: "2024-01-01",
      description: "Rent payment for January",
    ),
  ];

  // Calculate statistics
  double get _totalPaid {
    return _payments.fold(0.0, (sum, payment) {
      return payment.status == 'completed' ? sum + payment.amount : sum;
    });
  }

  int get _completedPayments {
    return _payments.where((payment) => payment.status == 'completed').length;
  }

  int get _tenancyDuration {
    // Calculate months from move-in date to now
    return 3; // Mock value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: _buildAppBar(),
      drawer: CustomAppBar.buildDrawer(context, _activeDrawerItem, (item) {
        setState(() => _activeDrawerItem = item);
      }),
      body: _isLoading
          ? _buildLoadingState()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Main Content
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Tenant Profile Card
                          _buildProfileCard(),
                          const SizedBox(height: 16),

                          // Statistics Cards
                          _buildStatisticsCards(),
                          const SizedBox(height: 16),

                          // Property Info
                          _buildPropertyCard(),
                          const SizedBox(height: 16),

                          // Payment History
                          _buildPaymentHistoryCard(),
                          const SizedBox(height: 16),

                          // Action Buttons
                          _buildActionButtons(),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  // AppBar Widget
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFFAFAFA),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A), size: 24),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Tenant Details',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
          color: Color(0xFF1A1A1A),
        ),
      ),
      centerTitle: false,
    );
  }

  // Loading State Widget
  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF22C55E)),
      ),
    );
  }

  // Profile Card Widget
  Widget _buildProfileCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar and Name
            Column(
              children: [
                // Avatar
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color(0xFF22C55E).withOpacity(0.2),
                        width: 4),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://api.dicebear.com/7.x/avataaars/svg?seed=${_tenant.fullName}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFF22C55E).withOpacity(0.1),
                        child: Center(
                          child: Text(
                            _tenant.fullName[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF22C55E),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Name and Badge
                Text(
                  _tenant.fullName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),

                // Status Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1FAE5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFF86EFAC)),
                  ),
                  child: Text(
                    _tenant.status,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF065F46),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),

            // Divider
            Container(
              margin: const EdgeInsets.symmetric(vertical: 24),
              height: 1,
              color: const Color(0xFFE5E5E7),
            ),

            // Contact Info
            Column(
              children: [
                // Email
                if (_tenant.email.isNotEmpty) ...[
                  _buildContactInfoRow(
                    icon: Icons.email,
                    title: 'Email',
                    value: _tenant.email,
                  ),
                  const SizedBox(height: 16),
                ],

                // Phone
                if (_tenant.phone.isNotEmpty) ...[
                  _buildContactInfoRow(
                    icon: Icons.phone,
                    title: 'Phone',
                    value: _tenant.phone,
                  ),
                  const SizedBox(height: 16),
                ],

                // Move-in Date
                if (_tenant.moveInDate.isNotEmpty) ...[
                  _buildContactInfoRow(
                    icon: Icons.calendar_today,
                    title: 'Move-in Date',
                    value: _formatDate(_tenant.moveInDate),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Contact Info Row Widget
  Widget _buildContactInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        // Icon Container
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF22C55E).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF22C55E),
          ),
        ),
        const SizedBox(width: 12),

        // Text Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF737373),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Statistics Cards Widget
  Widget _buildStatisticsCards() {
    return Row(
      children: [
        // Total Paid
        Expanded(
          child: _buildStatCard(
            icon: Icons.credit_card,
            value: '\$${_totalPaid.toStringAsFixed(0)}',
            label: 'Total Paid',
          ),
        ),
        const SizedBox(width: 8),

        // Tenancy Duration
        Expanded(
          child: _buildStatCard(
            icon: Icons.person,
            value: '$_tenancyDuration',
            label: 'Months',
          ),
        ),
        const SizedBox(width: 8),

        // Payments Count
        Expanded(
          child: _buildStatCard(
            icon: Icons.calendar_today,
            value: '$_completedPayments',
            label: 'Payments',
          ),
        ),
      ],
    );
  }

  // Single Stat Card Widget
  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5E7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 24,
              color: const Color(0xFF22C55E),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF22C55E),
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF737373),
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Property Card Widget
  Widget _buildPropertyCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'PROPERTY',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF737373),
                fontFamily: 'Poppins',
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 12),

            // Property Info
            Row(
              children: [
                // Icon Container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.apartment,
                    size: 24,
                    color: Color(0xFF22C55E),
                  ),
                ),
                const SizedBox(width: 12),

                // Property Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _tenant.propertyName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Color(0xFF737373),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _tenant.propertyAddress,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF737373),
                                fontFamily: 'Poppins',
                              ),
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

  // Payment History Card Widget
  Widget _buildPaymentHistoryCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Add Payment Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                const Text(
                  'RECENT PAYMENTS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF737373),
                    fontFamily: 'Poppins',
                    letterSpacing: 1,
                  ),
                ),

                // Add Payment Button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE5E5E7)),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        setState(() => _showAddTransaction = true);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              size: 16,
                              color: Color(0xFF1A1A1A),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Add Payment',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                color: Color(0xFF1A1A1A),
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
            const SizedBox(height: 16),

            // Payment List or Empty State
            if (_payments.isEmpty)
              // Empty State
              Column(
                children: [
                  Icon(
                    Icons.credit_card,
                    size: 48,
                    color: const Color(0xFFD4D4D4),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No payment history',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF737373),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              )
            else
              // Payment List
              Column(
                children: _payments
                    .map((payment) => _buildPaymentRow(payment))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }

  // Single Payment Row Widget
  Widget _buildPaymentRow(Payment payment) {
    final isCompleted = payment.status == 'completed';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFE5E5E7),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Payment Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted
                  ? const Color(0xFFD1FAE5)
                  : const Color(0xFFFFF7ED),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.credit_card,
              size: 20,
              color: isCompleted
                  ? const Color(0xFF22C55E)
                  : const Color(0xFFF59E0B),
            ),
          ),
          const SizedBox(width: 12),

          // Payment Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${payment.amount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatDate(payment.transactionDate),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF737373),
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),

          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isCompleted
                  ? const Color(0xFF22C55E).withOpacity(0.1)
                  : const Color(0xFFF59E0B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              payment.status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isCompleted
                    ? const Color(0xFF22C55E)
                    : const Color(0xFFF59E0B),
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Action Buttons Widget
  Widget _buildActionButtons() {
    return Row(
      children: [
        // Message Button
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E5E7)),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Navigate to chat
                  print('Message ${_tenant.fullName}');
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.chat,
                        size: 20,
                        color: Color(0xFF1A1A1A),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Message',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Call Button
        if (_tenant.phone.isNotEmpty) ...[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFF22C55E),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Make phone call
                    print('Calling ${_tenant.fullName} at ${_tenant.phone}');
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 20,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Call',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // Helper Methods
  String _formatDate(String dateString) {
    // Simple date formatting - in real app use intl package
    return dateString; // Simplified for this example
  }
}
