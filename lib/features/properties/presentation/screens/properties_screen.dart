// lib/features/properties/presentation/screens/properties_screen.dart
import 'package:flutter/material.dart';
import 'package:xirfadsan_receipt/features/properties/presentation/screens/EditPropertyScreen.dart';
import 'package:xirfadsan_receipt/features/properties/presentation/screens/add_property_screen.dart';
import 'package:xirfadsan_receipt/features/properties/presentation/screens/property_tenants_screen.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({super.key});

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {
  String _selectedFilter = "all";

  final List<Map<String, dynamic>> _allProperties = [
    {
      'id': 1,
      'title': 'Studio Cozy Studio Near Park',
      'location': 'Banaadir mogadishu somalia',
      'rent': 2095,
      'type': 'Apartment',
      'status': 'Available',
      'bedrooms': 3,
      'bathrooms': 2,
      'size': '5x7 m²',
      'image':
          'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
    },
    {
      'id': 2,
      'title': 'Studio Cozy Studio Near Park',
      'location': 'Banaadir mogadishu somalia',
      'rent': 2095,
      'type': 'Villa',
      'status': 'Rented',
      'bedrooms': 4,
      'bathrooms': 3,
      'size': '8x10 m²',
      'image':
          'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w-800',
    },
  ];

  final List<Map<String, String>> _filterButtons = [
    {'label': 'All', 'value': 'all'},
    {'label': 'Available', 'value': 'available'},
    {'label': 'Rented', 'value': 'rented'},
    {'label': 'Vacant', 'value': 'vacant'},
  ];

  List<Map<String, dynamic>> get _filteredProperties {
    if (_selectedFilter == "all") return _allProperties;
    return _allProperties
        .where((p) => p['status'].toLowerCase() == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Search Bar
              _buildSearchBar(),
              const SizedBox(height: 16),

              // Filter Tabs
              _buildFilterTabs(),
              const SizedBox(height: 16),

              // Properties List
              _buildPropertiesList(context),
              const SizedBox(height: 80), // Space for floating button
            ],
          ),
        ),
      ),

      // Floating Add Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const AddPropertyScreen(),
          ),
        ),
        backgroundColor: const Color(0xFF22C55E),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // ========== APP BAR ==========
  // AppBar _buildAppBar(BuildContext context) {
  //   return AppBar(
  //     leading: IconButton(
  //       onPressed: () => Scaffold.of(context).openDrawer(),
  //       icon: const Icon(Icons.menu, color: Colors.black),
  //     ),
  //     title: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           width: 30,
  //           height: 30,
  //           decoration: BoxDecoration(
  //             color: const Color(0xFF22C55E),
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: const Center(
  //             child: Icon(
  //               Icons.home,
  //               color: Colors.white,
  //               size: 18,
  //             ),
  //           ),
  //         ),
  //         const SizedBox(width: 8),
  //         const Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Gurihage',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w700,
  //                 color: Colors.black,
  //               ),
  //             ),
  //             Text(
  //               'Home Rent App',
  //               style: TextStyle(
  //                 fontSize: 10,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //     centerTitle: true,
  //     backgroundColor: Colors.white,
  //     elevation: 0,
  //     actions: [
  //       Stack(
  //         children: [
  //           IconButton(
  //             onPressed: () => print('Notifications'),
  //             icon:
  //                 const Icon(Icons.notifications_outlined, color: Colors.black),
  //           ),
  //           Positioned(
  //             right: 8,
  //             top: 8,
  //             child: Container(
  //               padding: const EdgeInsets.all(2),
  //               decoration: const BoxDecoration(
  //                 color: Colors.red,
  //                 shape: BoxShape.circle,
  //               ),
  //               constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
  //               child: const Text(
  //                 '3',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 8,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // ========== SEARCH BAR ==========
  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.search, color: Colors.grey, size: 20),
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search properties..',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          IconButton(
            onPressed: () => print('Filter'),
            icon: Icon(Icons.tune, color: const Color(0xFF22C55E), size: 20),
          ),
        ],
      ),
    );
  }

  // ========== FILTER TABS ==========
  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filterButtons.map((filter) {
          final isSelected = _selectedFilter == filter['value'];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter['label']!),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedFilter = filter['value']!);
              },
              selectedColor: const Color(0xFF22C55E),
              backgroundColor: const Color(0xFFF0F9F2),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF22C55E),
                fontWeight: FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ========== PROPERTIES LIST ==========
  Widget _buildPropertiesList(BuildContext context) {
    return Column(
      children: _filteredProperties.map((property) {
        return _buildPropertyCard(property, context);
      }).toList(),
    );
  }

  Widget _buildPropertyCard(
      Map<String, dynamic> property, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          // Property Image
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  image: DecorationImage(
                    image: NetworkImage(property['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Status Badge
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    property['status'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // Type Badge
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(
                    property['type'],
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Property Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price & Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${property['rent']}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF22C55E),
                      ),
                    ),
                    const Text(
                      '/month',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Property Title
                Text(
                  property['title'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),

                // Location
                Row(
                  children: [
                    Icon(Icons.location_on,
                        size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        property['location'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Property Features
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFeatureItem(
                      icon: Icons.bed,
                      text: '${property['bedrooms']} Bedroom',
                    ),
                    _buildFeatureItem(
                      icon: Icons.bathtub,
                      text: '${property['bathrooms']} Bath',
                    ),
                    _buildFeatureItem(
                      icon: Icons.aspect_ratio,
                      text: property['size'],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditPropertyScreen(property: property),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text('Edit'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF22C55E),
                          side: const BorderSide(color: Color(0xFF22C55E)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _navigateToTenants(property, context),
                        icon: const Icon(Icons.people, size: 18),
                        label: const Text('Tenants'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF22C55E),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF22C55E)),
        const SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  // ========== NAVIGATION TO TENANTS ==========
  void _navigateToTenants(Map<String, dynamic> property, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PropertyTenantsScreen(
          propertyId: property['id'].toString(),
          propertyName: property['title'],
          propertyAddress: property['location'],
        ),
      ),
    );
  }
}
