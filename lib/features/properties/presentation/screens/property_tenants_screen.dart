// lib/features/properties/presentation/screens/property_tenants_screen.dart
import 'package:flutter/material.dart';
import 'package:xirfadsan_receipt/features/tenants/presentation/screens/tenant_details_screen.dart';

class PropertyTenantsScreen extends StatefulWidget {
  final String propertyId;
  final String propertyName;
  final String propertyAddress;

  const PropertyTenantsScreen({
    super.key,
    required this.propertyId,
    required this.propertyName,
    required this.propertyAddress,
  });

  @override
  State<PropertyTenantsScreen> createState() => _PropertyTenantsScreenState();
}

class _PropertyTenantsScreenState extends State<PropertyTenantsScreen> {
  final List<Map<String, dynamic>> _tenants = [
    {
      'id': '1',
      'full_name': 'Ahmed Mohamed',
      'email': 'ahmed@example.com',
      'phone': '+252 61 123 4567',
      'move_in_date': '2024-03-15',
      'rent_status': 'Rent paid',
      'latest_payment': 850,
    },
    {
      'id': '2',
      'full_name': 'Fatima Hassan',
      'email': 'fatima@example.com',
      'phone': '+252 61 987 6543',
      'move_in_date': '2024-02-01',
      'rent_status': 'Pending',
      'latest_payment': 750,
    },
    {
      'id': '3',
      'full_name': 'Omar Ali',
      'email': 'omar@example.com',
      'phone': '+252 61 555 1234',
      'move_in_date': '2024-01-10',
      'rent_status': 'Rent paid',
      'latest_payment': 900,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Property Tenants',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              widget.propertyName,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showAddTenantDialog,
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  const Icon(Icons.person_add, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Property Info Card
          _buildPropertyInfoCard(),
          const SizedBox(height: 16),

          // Tenants List
          Expanded(
            child: _tenants.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _tenants.length,
                    itemBuilder: (context, index) {
                      return _buildTenantCard(_tenants[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyInfoCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF22C55E).withOpacity(0.1),
            const Color(0xFF22C55E).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.apartment,
              color: Color(0xFF22C55E),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.propertyName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        widget.propertyAddress,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.people,
                        size: 14,
                        color: Color(0xFF22C55E),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_tenants.length} Tenants',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF22C55E),
                          fontWeight: FontWeight.w600,
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

  Widget _buildTenantCard(Map<String, dynamic> tenant) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: Column(
        children: [
          // Tenant Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: const Color(0xFF22C55E).withOpacity(0.1),
                      child: Text(
                        tenant['full_name'][0],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF22C55E),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tenant['full_name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: tenant['rent_status'] == 'Rent paid'
                                      ? const Color(0xFF22C55E).withOpacity(0.1)
                                      : const Color(0xFFFFA500)
                                          .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: tenant['rent_status'] == 'Rent paid'
                                        ? const Color(0xFF22C55E)
                                            .withOpacity(0.3)
                                        : const Color(0xFFFFA500)
                                            .withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  tenant['rent_status'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: tenant['rent_status'] == 'Rent paid'
                                        ? const Color(0xFF22C55E)
                                        : const Color(0xFFFFA500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            tenant['email'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Payment & Move-in Info
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.credit_card,
                                            size: 14,
                                            color: Color(0xFF22C55E),
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            'Latest Payment',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '\$${tenant['latest_payment']}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF22C55E),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.people,
                                            size: 14,
                                            color: Color(0xFF22C55E),
                                          ),
                                          const SizedBox(width: 4),
                                          const Text(
                                            'Move-in Date',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _formatDate(tenant['move_in_date']),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF22C55E),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Phone Number
                          if (tenant['phone'] != null) ...[
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  tenant['phone'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action Buttons
          Container(
            height: 1,
            color: Colors.grey.shade200,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _onChatPressed(tenant['id']),
                  icon: const Icon(
                    Icons.message,
                    size: 18,
                    color: Color(0xFF22C55E),
                  ),
                  label: const Text(
                    'Chat',
                    style: TextStyle(color: Color(0xFF22C55E)),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 24,
                color: Colors.grey.shade200,
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: () => _navigateToTenantDetails(tenant),
                  icon: const Icon(
                    Icons.remove_red_eye,
                    size: 18,
                    color: Color(0xFF22C55E),
                  ),
                  label: const Text(
                    'Details',
                    style: TextStyle(color: Color(0xFF22C55E)),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              if (tenant['phone'] != null) ...[
                Container(
                  width: 1,
                  height: 24,
                  color: Colors.grey.shade200,
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _onCallPressed(tenant['phone']),
                    icon: const Icon(
                      Icons.phone,
                      size: 18,
                      color: Color(0xFF22C55E),
                    ),
                    label: const Text(
                      'Call',
                      style: TextStyle(color: Color(0xFF22C55E)),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Icon(
            Icons.people,
            size: 40,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'No tenants yet',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            'No tenants are currently assigned to this property. Add your first tenant to get started.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: _showAddTenantDialog,
          icon: const Icon(Icons.person_add, size: 20),
          label: const Text('Add First Tenant'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF22C55E),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    ));
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final monthNames = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${monthNames[date.month - 1]} ${date.year}';
    } catch (e) {
      return 'N/A';
    }
  }

  void _showAddTenantDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Tenant'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add tenant functionality will be implemented here.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Add tenant logic here
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _onChatPressed(String tenantId) {
    print('Chat with tenant $tenantId');
  }

  void _navigateToTenantDetails(Map<String, dynamic> tenant) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TenantDetailsScreen(
          tenantId: tenant['id'],
          tenantName: tenant['full_name'],
          tenantEmail: tenant['email'],
          tenantPhone: tenant['phone'],
        ),
      ),
    );
  }

  void _onCallPressed(String phoneNumber) {
    print('Call $phoneNumber');
  }
}
