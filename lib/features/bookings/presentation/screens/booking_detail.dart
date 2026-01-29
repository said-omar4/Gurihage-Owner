// lib/presentation/screens/booking_detail_screen.dart
import 'package:flutter/material.dart';

// ============================================
// 1. ENUMS & MODELS
// ============================================
enum BookingStatus { pending, approved, rejected }

class Booking {
  final int id;
  final String propertyName;
  final String location;
  final String tenantName;
  final String tenantAvatar;
  final String tenantEmail;
  final String tenantPhone;
  final double rent;
  final BookingStatus status;
  final String requestDate;
  final String moveInDate;
  final String message;

  Booking({
    required this.id,
    required this.propertyName,
    required this.location,
    required this.tenantName,
    required this.tenantAvatar,
    required this.tenantEmail,
    required this.tenantPhone,
    required this.rent,
    required this.status,
    required this.requestDate,
    required this.moveInDate,
    this.message = '',
  });

  // Factory method for mock data
  factory Booking.mock() {
    return Booking(
      id: 1,
      propertyName: 'Studio Cozy Studio Near Park',
      location: 'Banaadir Mogadishu Somalia',
      tenantName: 'Said-omar Ahmed',
      tenantAvatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=tenant1',
      tenantEmail: 'said.omar@example.com',
      tenantPhone: '+252 614465608',
      rent: 2099.0,
      status: BookingStatus.pending,
      requestDate: '2024-01-15',
      moveInDate: '2024-02-01',
      message:
          'I\'m interested in renting this property for long term. I have stable income and good references.',
    );
  }
}

// ============================================
// 2. COLOR CONSTANTS (Your Theme Colors)
// ============================================
class AppColors {
  // Light Theme Colors
  static const Color primaryLight = Color(0xFF22C55E); // hsl(143 76% 41%)
  static const Color backgroundLight = Color(0xFFFAFAFA); // hsl(0 0% 98%)
  static const Color foregroundLight = Color(0xFF1A1A1A); // hsl(240 10% 10%)
  static const Color cardLight = Color(0xFFFFFFFF); // hsl(0 0% 100%)
  static const Color mutedLight = Color(0xFFF5F5F5); // hsl(240 5% 96%)
  static const Color borderLight = Color(0xFFE5E5E7); // hsl(240 6% 90%)
  static const Color destructiveLight = Color(0xFFDC2626); // hsl(0 84% 60%)
  static const Color mutedForegroundLight =
      Color(0xFF737373); // hsl(240 4% 46%)
  static const Color secondaryLight = Color(0xFFF0F9F2); // hsl(143 20% 95%)
  static const Color secondaryForegroundLight =
      Color(0xFF15803D); // hsl(143 76% 35%)
}

// ============================================
// 3. MAIN SCREEN WIDGET
// ============================================
class BookingDetailScreen extends StatelessWidget {
  final Booking booking;

  const BookingDetailScreen({Key? key, required this.booking})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Back Button
            _buildHeader(context),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Property Image & Details
                    _buildPropertyCard(),

                    const SizedBox(height: 16),

                    // Tenant Information
                    _buildTenantCard(),

                    const SizedBox(height: 16),

                    // Booking Details
                    _buildBookingDetailsCard(),

                    const SizedBox(height: 16),

                    // Tenant Message
                    if (booking.message.isNotEmpty) _buildMessageCard(),

                    const SizedBox(height: 24),

                    // Action Buttons (Show only if pending)
                    if (booking.status == BookingStatus.pending)
                      _buildActionButtons(context),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // 4. HEADER WIDGET
  // ============================================
  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        border:
            Border(bottom: BorderSide(color: AppColors.borderLight, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Back Button
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back,
                size: 24, color: AppColors.foregroundLight),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),

          const SizedBox(width: 12),

          // Title
          Text(
            'Booking Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.foregroundLight,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // 5. PROPERTY CARD WIDGET
  // ============================================
  Widget _buildPropertyCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Property Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: AppColors.mutedLight,
                child: Center(
                    child: Icon(Icons.home,
                        size: 50, color: AppColors.mutedForegroundLight)),
              ),
            ),
          ),

          // Property Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color:
                            _getStatusColor(booking.status).withOpacity(0.3)),
                  ),
                  child: Text(
                    _formatStatus(booking.status),
                    style: TextStyle(
                      color: _getStatusColor(booking.status),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Property Title
                Text(
                  booking.propertyName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.foregroundLight,
                  ),
                ),

                const SizedBox(height: 8),

                // Location with Icon
                Row(
                  children: [
                    Icon(Icons.location_on,
                        size: 16, color: AppColors.mutedForegroundLight),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        booking.location,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.mutedForegroundLight,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Rent Price
                RichText(
                  text: TextSpan(
                    text: '\$${booking.rent.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryLight,
                    ),
                    children: [
                      TextSpan(
                        text: '/month',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: AppColors.mutedForegroundLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // 6. TENANT CARD WIDGET
  // ============================================
  Widget _buildTenantCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Tenant Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryLight,
            ),
          ),

          const SizedBox(height: 16),

          // Tenant Profile
          Row(
            children: [
              // Avatar
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.borderLight, width: 2),
                ),
                child: ClipOval(
                  child: booking.tenantAvatar.isNotEmpty
                      ? Image.network(
                          booking.tenantAvatar,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildAvatarFallback(),
                        )
                      : _buildAvatarFallback(),
                ),
              ),

              const SizedBox(width: 12),

              // Tenant Name & Role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.tenantName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.foregroundLight,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Potential Tenant',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.mutedForegroundLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Contact Info Cards
          Column(
            children: [
              // Email Card
              _buildContactCard(
                icon: Icons.email,
                title: 'Email',
                value: booking.tenantEmail,
                iconColor: AppColors.primaryLight,
              ),

              const SizedBox(height: 8),

              // Phone Card
              _buildContactCard(
                icon: Icons.phone,
                title: 'Phone',
                value: booking.tenantPhone,
                iconColor: AppColors.primaryLight,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Contact Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _makePhoneCall(booking.tenantPhone),
                  icon: const Icon(Icons.phone, size: 18),
                  label: const Text('Call'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: BorderSide(color: AppColors.borderLight),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _sendEmail(booking.tenantEmail),
                  icon: const Icon(Icons.email, size: 18),
                  label: const Text('Email'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: BorderSide(color: AppColors.borderLight),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================
  // 7. BOOKING DETAILS CARD
  // ============================================
  Widget _buildBookingDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Booking Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryLight,
            ),
          ),

          const SizedBox(height: 16),

          // Details List
          Column(
            children: [
              _buildDetailRow(
                  label: 'Request Date', value: booking.requestDate),
              const SizedBox(height: 12),
              _buildDetailRow(label: 'Move-in Date', value: booking.moveInDate),
              const SizedBox(height: 12),
              // Rent with special styling
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monthly Rent',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.mutedForegroundLight,
                    ),
                  ),
                  Text(
                    '\$${booking.rent.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================
  // 8. MESSAGE CARD WIDGET
  // ============================================
  Widget _buildMessageCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderLight, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Message from Tenant',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryLight,
            ),
          ),

          const SizedBox(height: 12),

          // Message Content
          Text(
            booking.message,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.mutedForegroundLight,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // 9. ACTION BUTTONS WIDGET
  // ============================================
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        // Reject Button
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.destructiveLight, width: 2),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _handleReject(context),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel,
                          size: 20, color: AppColors.destructiveLight),
                      const SizedBox(width: 8),
                      Text(
                        'Reject',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.destructiveLight,
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

        // Approve Button
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.primaryLight,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _handleApprove(context),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle,
                          size: 20, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        'Approve',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
    );
  }

  // ============================================
  // 10. HELPER WIDGETS
  // ============================================
  Widget _buildAvatarFallback() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.mutedLight,
      ),
      child: Center(
        child: Text(
          booking.tenantName.isNotEmpty
              ? booking.tenantName[0].toUpperCase()
              : 'T',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.foregroundLight,
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.mutedLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.mutedForegroundLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.foregroundLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.mutedForegroundLight,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.foregroundLight,
          ),
        ),
      ],
    );
  }

  // ============================================
  // 11. HELPER METHODS
  // ============================================
  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return Colors.amber.shade700;
      case BookingStatus.approved:
        return AppColors.primaryLight;
      case BookingStatus.rejected:
        return AppColors.destructiveLight;
    }
  }

  String _formatStatus(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.approved:
        return 'Approved';
      case BookingStatus.rejected:
        return 'Rejected';
    }
  }

  void _makePhoneCall(String phoneNumber) {
    // Implement phone call
    print('📞 Calling: $phoneNumber');
    // You can use: url_launcher package
  }

  void _sendEmail(String email) {
    // Implement email
    print('📧 Emailing: $email');
    // You can use: url_launcher package
  }

  void _handleApprove(BuildContext context) {
    print('✅ Booking Approved');
    Navigator.pop(context);
  }

  void _handleReject(BuildContext context) {
    print('❌ Booking Rejected');
    Navigator.pop(context);
  }
}
