// lib/presentation/screens/tenants.dart
import 'package:flutter/material.dart';
import 'package:xirfadsan_receipt/appbar.dart';

// ============================================
// DATA MODELS
// ============================================
class Tenant {
  final int id;
  final String name;
  final String avatar;
  final String property;
  final int rent;
  final String moveInDate;
  final String status;

  const Tenant({
    required this.id,
    required this.name,
    required this.avatar,
    required this.property,
    required this.rent,
    required this.moveInDate,
    required this.status,
  });
}

// ============================================
// TENANTS SCREEN
// ============================================
class TenantsScreen extends StatefulWidget {
  const TenantsScreen({super.key});

  @override
  State<TenantsScreen> createState() => _TenantsScreenState();
}

class _TenantsScreenState extends State<TenantsScreen> {
  bool _isLoading = true;
  bool _isRefreshing = false;
  final TextEditingController _searchController = TextEditingController();
  DrawerItem _activeDrawerItem = DrawerItem.tenants;

  // Tenants data
  final List<Tenant> _tenants = [
    const Tenant(
      id: 1,
      name: "Said-omar ahmed",
      avatar: "https://api.dicebear.com/7.x/avataaars/svg?seed=tenant1",
      property: "Dahab Tower",
      rent: 2095,
      moveInDate: "2025-08-15",
      status: "Active",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _isLoading = false;
      _isRefreshing = false;
    });
  }

  Future<void> _handleRefresh() async {
    setState(() => _isRefreshing = true);
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Pull to Refresh Button
              _buildRefreshButton(),
              const SizedBox(height: 8),

              // Main Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Search Bar
                    _buildSearchBar(),
                    const SizedBox(height: 20),

                    // Tenants List
                    _buildTenantsList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Refresh Button Widget
  Widget _buildRefreshButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: _handleRefresh,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.refresh,
                size: 16,
                color: const Color(0xFF737373),
              ),
              const SizedBox(width: 8),
              Text(
                _isRefreshing ? 'Refreshing...' : 'Pull to refresh',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF737373),
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
            size: 20,
            color: Color(0xFF737373),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search tenant..',
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

  // Tenants List Widget
  Widget _buildTenantsList() {
    if (_isLoading) {
      return Column(
        children: [
          _buildTenantCardSkeleton(),
          const SizedBox(height: 12),
          _buildTenantCardSkeleton(),
        ],
      );
    }

    if (_tenants.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: const Column(
          children: [
            Icon(
              Icons.people,
              size: 64,
              color: Color(0xFFD4D4D4),
            ),
            SizedBox(height: 16),
            Text(
              'No tenants found',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF737373),
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: _tenants.map((tenant) => _buildTenantCard(tenant)).toList(),
    );
  }

  // Tenant Card Skeleton Widget
  Widget _buildTenantCardSkeleton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Top row: Avatar and info
            Row(
              children: [
                // Avatar skeleton
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),

                // Info skeleton
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 120,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                width: 80,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 60,
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Rent and Move-in date skeleton
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 16,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 100,
                        height: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 16,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 90,
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Buttons skeleton
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E5E7)),
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

  // Single Tenant Card Widget
  Widget _buildTenantCard(Tenant tenant) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Top row: Avatar and info
            Row(
              children: [
                // Avatar
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE5E5E7)),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      tenant.avatar,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFFF5F5F5),
                        child: Center(
                          child: Text(
                            tenant.name[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20,
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

                // Tenant info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tenant.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tenant.property,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF737373),
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),

                          // Status badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1FAE5),
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: const Color(0xFF86EFAC)),
                            ),
                            child: Text(
                              tenant.status,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF065F46),
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
            const SizedBox(height: 16),

            // Rent and Move-in date
            Row(
              children: [
                // Rent amount
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rent Amount',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF737373),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${tenant.rent} /month',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF22C55E),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),

                // Move-in date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Move-in Date',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF737373),
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tenant.moveInDate,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF22C55E),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Call and Chat buttons
            Row(
              children: [
                // Call button
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF22C55E),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // Handle call
                          print('Calling ${tenant.name}');
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 18,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Call',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
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
                const SizedBox(width: 8),

                // Chat button
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E5E7)),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // Handle chat
                          print('Chat with ${tenant.name}');
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.chat,
                                size: 18,
                                color: Color(0xFF1A1A1A),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Chat',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1A1A1A),
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
            ),
          ],
        ),
      ),
    );
  }
}
