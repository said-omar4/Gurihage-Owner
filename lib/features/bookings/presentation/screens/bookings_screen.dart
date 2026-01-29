import 'package:flutter/material.dart';
import 'package:xirfadsan_receipt/appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookings Screen',
      theme: ThemeData(
        primaryColor: const Color(0xFF22C55E),
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFAFAFA),
          elevation: 0,
          centerTitle: false,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const BookingsScreen(),
    );
  }
}

// ============================================
// BOOKING STATUS ENUM
// ============================================
enum BookingStatus {
  pending,
  approved,
  rejected;

  String get name {
    switch (this) {
      case BookingStatus.pending:
        return 'pending';
      case BookingStatus.approved:
        return 'approved';
      case BookingStatus.rejected:
        return 'rejected';
    }
  }
}

// ============================================
// BOOKING MODEL
// ============================================
class Booking {
  final int id;
  final String property;
  final String location;
  final String tenantName;
  final int rent;
  final BookingStatus status;
  final String imageUrl;
  final String tenantAvatar;
  final String tenantEmail;
  final String tenantPhone;
  final String requestDate;
  final String moveInDate;
  final String message;

  const Booking({
    required this.id,
    required this.property,
    required this.location,
    required this.tenantName,
    required this.rent,
    required this.status,
    required this.imageUrl,
    this.tenantAvatar =
        'https://api.dicebear.com/7.x/avataaars/svg?seed=tenant',
    this.tenantEmail = 'tenant@example.com',
    this.tenantPhone = '+252 61 0000000',
    this.requestDate = '2024-01-15',
    this.moveInDate = '2024-02-01',
    this.message = 'I\'m interested in renting this property for long term.',
  });
}

// ============================================
// FILTER TAB MODEL
// ============================================
class FilterTab {
  final String label;
  final String value;

  const FilterTab({
    required this.label,
    required this.value,
  });
}

// ============================================
// BOOKING DETAIL SCREEN (Added Here)
// ============================================
class BookingDetailScreen extends StatelessWidget {
  final Booking booking;

  const BookingDetailScreen({super.key, required this.booking});

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
              // Property Card
              _buildPropertyCard(),
              const SizedBox(height: 16),

              // Tenant Information
              _buildTenantCard(),
              const SizedBox(height: 16),

              // Booking Details
              _buildBookingDetailsCard(),
              const SizedBox(height: 16),

              // Tenant Message
              _buildMessageCard(),
              const SizedBox(height: 24),

              // Action Buttons
              if (booking.status == BookingStatus.pending)
                _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildHeader(BuildContext context) {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       color: Color(0xFFFAFAFA),
  //       border: Border(
  //         bottom: BorderSide(color: Color(0xFFE5E5E7), width: 1),
  //       ),
  //     ),
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //     child: Row(
  //       children: [
  //         IconButton(
  //           onPressed: () => Navigator.pop(context),
  //           icon: const Icon(Icons.arrow_back,
  //               size: 24, color: Color(0xFF1A1A1A)),
  //         ),
  //         const SizedBox(width: 8),
  //         const Text(
  //           'Booking Details',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.w600,
  //             color: Color(0xFF1A1A1A),
  //             fontFamily: 'Poppins',
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildPropertyCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E7)),
      ),
      child: Column(
        children: [
          // Property Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Container(
              height: 200,
              color: const Color(0xFFF5F5F5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.home, size: 50, color: Color(0xFFD4D4D4)),
                    const SizedBox(height: 8),
                    Text(
                      booking.property,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFA3A3A3),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
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
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Property Title
                Text(
                  booking.property,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                    fontFamily: 'Poppins',
                  ),
                ),

                const SizedBox(height: 8),

                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 16, color: Color(0xFF737373)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        booking.location,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF737373),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Rent Price
                RichText(
                  text: TextSpan(
                    text: '\$${booking.rent}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF22C55E),
                      fontFamily: 'Poppins',
                    ),
                    children: const [
                      TextSpan(
                        text: '/month',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF737373),
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

  Widget _buildTenantCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E7)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Tenant Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF22C55E),
              fontFamily: 'Poppins',
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
                  border: Border.all(color: const Color(0xFFE5E5E7)),
                ),
                child: ClipOval(
                  child: Image.network(
                    booking.tenantAvatar,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildAvatarFallback(),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Tenant Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.tenantName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Potential Tenant',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF737373),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Contact Info
          Column(
            children: [
              // Email
              _buildContactCard(
                icon: Icons.email,
                title: 'Email',
                value: booking.tenantEmail,
                color: const Color(0xFF22C55E),
              ),
              const SizedBox(height: 8),

              // Phone
              _buildContactCard(
                icon: Icons.phone,
                title: 'Phone',
                value: booking.tenantPhone,
                color: const Color(0xFF22C55E),
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
                    side: const BorderSide(color: Color(0xFFE5E5E7)),
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
                    side: const BorderSide(color: Color(0xFFE5E5E7)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E7)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF22C55E),
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              _buildDetailRow(
                  label: 'Request Date', value: booking.requestDate),
              const SizedBox(height: 12),
              _buildDetailRow(label: 'Move-in Date', value: booking.moveInDate),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Monthly Rent',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF737373),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    '\$${booking.rent}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF22C55E),
                      fontFamily: 'Poppins',
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

  Widget _buildMessageCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E7)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Message from Tenant',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF22C55E),
              fontFamily: 'Poppins',
            ),
          ),
          const SizedBox(height: 12),
          Text(
            booking.message,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF737373),
              fontFamily: 'Poppins',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        // Reject Button
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFDC2626), width: 2),
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
                      const Icon(Icons.cancel,
                          size: 20, color: Color(0xFFDC2626)),
                      const SizedBox(width: 8),
                      const Text(
                        'Reject',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFDC2626),
                          fontFamily: 'Poppins',
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
              color: const Color(0xFF22C55E),
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
                      const Text(
                        'Approve',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Poppins',
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

  // Helper Widgets
  Widget _buildAvatarFallback() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFF5F5F5),
      ),
      child: Center(
        child: Text(
          booking.tenantName.isNotEmpty
              ? booking.tenantName[0].toUpperCase()
              : 'T',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
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
                    color: Color(0xFF1A1A1A),
                    fontFamily: 'Poppins',
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
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF737373),
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A1A1A),
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  // Helper Methods
  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return Colors.amber.shade700;
      case BookingStatus.approved:
        return const Color(0xFF22C55E);
      case BookingStatus.rejected:
        return const Color(0xFFDC2626);
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
    print('📞 Calling: $phoneNumber');
    // Add url_launcher package for actual calling
  }

  void _sendEmail(String email) {
    print('📧 Emailing: $email');
    // Add url_launcher package for actual email
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

// ============================================
// BOOKINGS SCREEN (WITH NAVIGATION)
// ============================================
class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  String _selectedFilter = 'all';
  final TextEditingController _searchController = TextEditingController();

  // Define colors for the app
  static const Color primaryColor = Color(0xFF22C55E);
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color onSurfaceColor = Color(0xFF1A1A1A);
  static const Color outlineColor = Color(0xFFE5E5E7);
  static const Color mutedForegroundColor = Color(0xFF737373);

  // Booking data
  final List<Booking> _allBookings = [
    Booking(
      id: 1,
      property: 'Studio Cozy Studio Near Park',
      location: 'Banaadir mogadishu somalia',
      tenantName: 'Said-omar ahmed',
      rent: 2099,
      status: BookingStatus.pending,
      imageUrl:
          'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
      tenantAvatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=said',
      tenantEmail: 'said.omar@example.com',
      tenantPhone: '+252 614465608',
      requestDate: '2024-01-15',
      moveInDate: '2024-02-01',
      message:
          'I\'m interested in renting this property for long term. I have stable income and good references.',
    ),
    Booking(
      id: 2,
      property: 'Studio Cozy Studio Near Park',
      location: 'Banaadir mogadishu somalia',
      tenantName: 'Said-omar ahmed',
      rent: 2099,
      status: BookingStatus.approved,
      imageUrl:
          'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
      tenantAvatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=ahmed',
      tenantEmail: 'ahmed@example.com',
      tenantPhone: '+252 614465609',
      requestDate: '2024-01-10',
      moveInDate: '2024-01-25',
    ),
    Booking(
      id: 3,
      property: 'Modern Apartment Downtown',
      location: 'Hodan, Mogadishu',
      tenantName: 'Ahmed Ali',
      rent: 1500,
      status: BookingStatus.pending,
      imageUrl:
          'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
      tenantAvatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=ali',
      tenantEmail: 'ali@example.com',
      tenantPhone: '+252 614465610',
      requestDate: '2024-01-12',
      moveInDate: '2024-02-15',
      message: 'Looking for a quiet place to work from home.',
    ),
    Booking(
      id: 4,
      property: 'Luxury Villa Beachfront',
      location: 'Liido, Mogadishu',
      tenantName: 'Fatima Hassan',
      rent: 3500,
      status: BookingStatus.rejected,
      imageUrl:
          'https://images.unsplash.com/photo-1613977257363-707ba9348227?w=800',
      tenantAvatar: 'https://api.dicebear.com/7.x/avataaars/svg?seed=fatima',
      tenantEmail: 'fatima@example.com',
      tenantPhone: '+252 614465611',
      requestDate: '2024-01-05',
      moveInDate: '2024-03-01',
    ),
  ];

  List<Booking> get _filteredBookings {
    if (_selectedFilter == 'all') return _allBookings;
    return _allBookings.where((booking) {
      return booking.status.name == _selectedFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Search Bar
              _buildSearchBar(),
              const SizedBox(height: 20),

              // Filter Tabs
              _buildFilterTabs(),
              const SizedBox(height: 20),

              // Bookings List
              _buildBookingsList(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: outlineColor,
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(
            Icons.search,
            color: mutedForegroundColor,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search bookings...',
                hintStyle: TextStyle(
                  color: mutedForegroundColor,
                  fontFamily: 'Poppins',
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: onSurfaceColor,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            color: primaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final List<FilterTab> filterTabs = [
      const FilterTab(label: 'All', value: 'all'),
      const FilterTab(label: 'Pending', value: 'pending'),
      const FilterTab(label: 'Approved', value: 'approved'),
      const FilterTab(label: 'Rejected', value: 'rejected'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filterTabs.map((tab) {
          final isSelected = _selectedFilter == tab.value;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(
                tab.label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: isSelected ? Colors.white : onSurfaceColor,
                ),
              ),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  _selectedFilter = tab.value;
                });
              },
              backgroundColor: surfaceColor,
              selectedColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? primaryColor : outlineColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBookingsList() {
    if (_filteredBookings.isEmpty) {
      return const Center(
        child: Column(
          children: [
            Icon(
              Icons.calendar_today,
              size: 64,
              color: mutedForegroundColor,
            ),
            SizedBox(height: 16),
            Text(
              'No bookings found',
              style: TextStyle(
                color: outlineColor,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredBookings.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return _buildBookingCard(_filteredBookings[index]);
      },
    );
  }

  Widget _buildBookingCard(Booking booking) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: outlineColor,
        ),
      ),
      elevation: 2,
      color: surfaceColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Property Image with Status Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Container(
                  height: 180,
                  color: const Color(0xFFF5F5F5),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.home,
                          size: 60,
                          color: Color(0xFFD4D4D4),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          booking.property,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFA3A3A3),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: _buildStatusBadge(booking.status),
              ),
            ],
          ),

          // Property Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Property Title
                Text(
                  booking.property,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: onSurfaceColor,
                  ),
                ),
                const SizedBox(height: 8),

                // Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: mutedForegroundColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        booking.location,
                        style: const TextStyle(
                          fontSize: 14,
                          color: mutedForegroundColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Tenant Info and Price
                Row(
                  children: [
                    // Tenant Avatar
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: primaryColor.withOpacity(0.1),
                      child: Text(
                        booking.tenantName[0].toUpperCase(),
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Tenant Name and Price
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.tenantName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: onSurfaceColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${booking.rent}/month',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // View Details Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // ✅ NAVIGATION ADDED HERE
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BookingDetailScreen(booking: booking),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.remove_red_eye, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'View Details',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BookingStatus status) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status) {
      case BookingStatus.pending:
        backgroundColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFF92400E);
        label = 'Pending';
        break;
      case BookingStatus.approved:
        backgroundColor = const Color(0xFFD1FAE5);
        textColor = const Color(0xFF065F46);
        label = 'Approved';
        break;
      case BookingStatus.rejected:
        backgroundColor = const Color(0xFFFEE2E2);
        textColor = const Color(0xFF991B1B);
        label = 'Rejected';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: textColor.withOpacity(0.2),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
