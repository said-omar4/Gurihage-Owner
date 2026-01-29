// lib/presentation/screens/complaints.dart
import 'package:flutter/material.dart';
import 'package:xirfadsan_receipt/appbar.dart';
import 'package:xirfadsan_receipt/features/complaint/complaint_detail.dart';

// ============================================
// DATA MODELS
// ============================================
class Complaint {
  final String id;
  final String category;
  final String property;
  final String location;
  final String date;
  final String status;

  const Complaint({
    required this.id,
    required this.category,
    required this.property,
    required this.location,
    required this.date,
    required this.status,
  });
}

// ============================================
// COMPLAINTS SCREEN
// ============================================
class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  String _selectedFilter = "all";
  bool _isLoading = true;
  bool _isRefreshing = false;
  final TextEditingController _searchController = TextEditingController();

  DrawerItem _activeDrawerItem = DrawerItem.complaints;

  // Filter buttons data
  final List<Map<String, String>> _filterButtons = [
    {'label': 'All', 'value': 'all'},
    {'label': 'Pending', 'value': 'pending'},
    {'label': 'In progress', 'value': 'in-progress'},
    {'label': 'Resolved', 'value': 'resolved'},
  ];

  // All complaints data
  final List<Complaint> _allComplaints = [
    const Complaint(
      id: "C001111",
      category: "Electricity",
      property: "Studio Cozy Studio Near Park",
      location: "Banaadir mogadishu somalia",
      date: "2024-01-15",
      status: "pending",
    ),
    const Complaint(
      id: "C001112",
      category: "Electricity",
      property: "Studio Cozy Studio Near Park",
      location: "Banaadir mogadishu somalia",
      date: "2024-01-15",
      status: "resolved",
    ),
    const Complaint(
      id: "C001113",
      category: "Electricity",
      property: "Studio Cozy Studio Near Park",
      location: "Banaadir mogadishu somalia",
      date: "2024-01-15",
      status: "in-progress",
    ),
  ];

  // Get filtered complaints
  List<Complaint> get _filteredComplaints {
    if (_selectedFilter == "all") return _allComplaints;
    return _allComplaints.where((c) => c.status == _selectedFilter).toList();
  }

  @override
  void initState() {
    super.initState();
    // Simulate loading data
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

  // Colors for complaint categories
  Map<String, Map<String, Color>> get _categoryColors => {
        'Electricity': {
          'background': const Color(0xFFFFF7ED),
          'text': const Color(0xFFC2410C),
          'border': const Color(0xFFFDBA74),
        },
        'AC': {
          'background': const Color(0xFFEFF6FF),
          'text': const Color(0xFF1D4ED8),
          'border': const Color(0xFF93C5FD),
        },
        'Plumbing': {
          'background': const Color(0xFFECFEFF),
          'text': const Color(0xFF0E7490),
          'border': const Color(0xFF67E8F9),
        },
      };

  // Colors for complaint status
  Map<String, Map<String, Color>> get _statusColors => {
        'pending': {
          'background': const Color(0xFFFEF3C7),
          'text': const Color(0xFF92400E),
          'border': const Color(0xFFFCD34D),
        },
        'in-progress': {
          'background': const Color(0xFFDBEAFE),
          'text': const Color(0xFF1E40AF),
          'border': const Color(0xFF93C5FD),
        },
        'resolved': {
          'background': const Color(0xFFD1FAE5),
          'text': const Color(0xFF065F46),
          'border': const Color(0xFF86EFAC),
        },
      };

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
                    const SizedBox(height: 16),

                    // Filter Tabs
                    _buildFilterTabs(),
                    const SizedBox(height: 20),

                    // Complaints List
                    _buildComplaintsList(),
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
                hintText: 'Search complaints..',
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

  // Filter Tabs Widget
  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filterButtons.map((filter) {
          final isSelected = _selectedFilter == filter['value'];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = filter['value']!),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF22C55E)
                      : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  filter['label']!,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: isSelected ? Colors.white : const Color(0xFF1A1A1A),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Complaints List Widget
  Widget _buildComplaintsList() {
    if (_isLoading) {
      return Column(
        children: [
          _buildComplaintCardSkeleton(),
          const SizedBox(height: 12),
          _buildComplaintCardSkeleton(),
          const SizedBox(height: 12),
          _buildComplaintCardSkeleton(),
        ],
      );
    }

    if (_filteredComplaints.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        child: const Column(
          children: [
            Icon(
              Icons.report_problem,
              size: 64,
              color: Color(0xFFD4D4D4),
            ),
            SizedBox(height: 16),
            Text(
              'No complaints found',
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
      children: _filteredComplaints
          .map((complaint) => _buildComplaintCard(complaint, context))
          .toList(),
    );
  }

  // Complaint Card Skeleton Widget
  Widget _buildComplaintCardSkeleton() {
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
            // Top row skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 64,
                      height: 24,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 80,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Middle section skeleton
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 160,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Bottom row skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  width: 112,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Single Complaint Card Widget
  Widget _buildComplaintCard(Complaint complaint, BuildContext context) {
    final categoryColor =
        _categoryColors[complaint.category] ?? _categoryColors['Electricity']!;
    final statusColor =
        _statusColors[complaint.status] ?? _statusColors['pending']!;

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
            // Top row: Category badges and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Category badges
                Row(
                  children: [
                    // Category badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: categoryColor['background'],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: categoryColor['border']!),
                      ),
                      child: Text(
                        complaint.category,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: categoryColor['text'],
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // ID badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: const Color(0xFF22C55E).withOpacity(0.2)),
                      ),
                      child: Text(
                        complaint.id,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF22C55E),
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),

                // Status badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor['background'],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor['border']!),
                  ),
                  child: Text(
                    _formatStatus(complaint.status),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: statusColor['text'],
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Property and Location
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  complaint.property,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),

                // Location with icon
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: const Color(0xFF737373),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      complaint.location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF737373),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Bottom row: Date and View Details button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date
                Text(
                  complaint.date,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF737373),
                    fontFamily: 'Poppins',
                  ),
                ),

                // View Details button
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xFF22C55E),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Navigate to complaint details screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComplaintDetailScreen(
                              complaintId: complaint.id,
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: const Text(
                          'View details',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontFamily: 'Poppins',
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

  // Helper method to format status text
  String _formatStatus(String status) {
    if (status == 'in-progress') return 'In-progress';
    return status[0].toUpperCase() + status.substring(1);
  }
}

// // lib/presentation/screens/complaints_screen.dart
// import 'package:flutter/material.dart';
// import 'package:xirfadsan_receipt/appbar.dart';

// // ============================================
// // DATA MODELS
// // ============================================
// class Complaint {
//   final String id;
//   final String category;
//   final String property;
//   final String location;
//   final String date;
//   final String status;

//   const Complaint({
//     required this.id,
//     required this.category,
//     required this.property,
//     required this.location,
//     required this.date,
//     required this.status,
//   });
// }

// // ============================================
// // COMPLAINTS SCREEN
// // ============================================
// class ComplaintsScreen extends StatefulWidget {
//   const ComplaintsScreen({super.key});

//   @override
//   State<ComplaintsScreen> createState() => _ComplaintsScreenState();
// }

// class _ComplaintsScreenState extends State<ComplaintsScreen> {
//   String _selectedFilter = "all";
//   bool _isLoading = true;
//   bool _isRefreshing = false;
//   final TextEditingController _searchController = TextEditingController();

//   DrawerItem _activeDrawerItem = DrawerItem.complaints;

//   // Filter buttons data
//   final List<Map<String, String>> _filterButtons = [
//     {'label': 'All', 'value': 'all'},
//     {'label': 'Pending', 'value': 'pending'},
//     {'label': 'In progress', 'value': 'in-progress'},
//     {'label': 'Resolved', 'value': 'resolved'},
//   ];

//   // All complaints data
//   final List<Complaint> _allComplaints = [
//     const Complaint(
//       id: "C001111",
//       category: "Electricity",
//       property: "Studio Cozy Studio Near Park",
//       location: "Banaadir mogadishu somalia",
//       date: "2024-01-15",
//       status: "pending",
//     ),
//     const Complaint(
//       id: "C001112",
//       category: "Electricity",
//       property: "Studio Cozy Studio Near Park",
//       location: "Banaadir mogadishu somalia",
//       date: "2024-01-15",
//       status: "resolved",
//     ),
//     const Complaint(
//       id: "C001113",
//       category: "Electricity",
//       property: "Studio Cozy Studio Near Park",
//       location: "Banaadir mogadishu somalia",
//       date: "2024-01-15",
//       status: "in-progress",
//     ),
//   ];

//   // Get filtered complaints
//   List<Complaint> get _filteredComplaints {
//     if (_selectedFilter == "all") return _allComplaints;
//     return _allComplaints.where((c) => c.status == _selectedFilter).toList();
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Simulate loading data
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     await Future.delayed(const Duration(milliseconds: 800));
//     setState(() {
//       _isLoading = false;
//       _isRefreshing = false;
//     });
//   }

//   Future<void> _handleRefresh() async {
//     setState(() => _isRefreshing = true);
//     await _loadData();
//   }

//   // Colors for complaint categories
//   Map<String, Map<String, Color>> get _categoryColors => {
//         'Electricity': {
//           'background': const Color(0xFFFFF7ED),
//           'text': const Color(0xFFC2410C),
//           'border': const Color(0xFFFDBA74),
//         },
//         'AC': {
//           'background': const Color(0xFFEFF6FF),
//           'text': const Color(0xFF1D4ED8),
//           'border': const Color(0xFF93C5FD),
//         },
//         'Plumbing': {
//           'background': const Color(0xFFECFEFF),
//           'text': const Color(0xFF0E7490),
//           'border': const Color(0xFF67E8F9),
//         },
//       };

//   // Colors for complaint status
//   Map<String, Map<String, Color>> get _statusColors => {
//         'pending': {
//           'background': const Color(0xFFFEF3C7),
//           'text': const Color(0xFF92400E),
//           'border': const Color(0xFFFCD34D),
//         },
//         'in-progress': {
//           'background': const Color(0xFFDBEAFE),
//           'text': const Color(0xFF1E40AF),
//           'border': const Color(0xFF93C5FD),
//         },
//         'resolved': {
//           'background': const Color(0xFFD1FAE5),
//           'text': const Color(0xFF065F46),
//           'border': const Color(0xFF86EFAC),
//         },
//       };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFAFAFA),
//       appBar: CustomAppBar.buildAppBar(context),
//       drawer: CustomAppBar.buildDrawer(context, _activeDrawerItem, (item) {
//         setState(() => _activeDrawerItem = item);
//       }),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Column(
//             children: [
//               // Pull to Refresh Button
//               _buildRefreshButton(),
//               const SizedBox(height: 8),

//               // Main Content
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     // Search Bar
//                     _buildSearchBar(),
//                     const SizedBox(height: 16),

//                     // Filter Tabs
//                     _buildFilterTabs(),
//                     const SizedBox(height: 20),

//                     // Complaints List
//                     _buildComplaintsList(),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Refresh Button Widget
//   Widget _buildRefreshButton() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: GestureDetector(
//         onTap: _handleRefresh,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.refresh,
//                 size: 16,
//                 color: const Color(0xFF737373),
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 _isRefreshing ? 'Refreshing...' : 'Pull to refresh',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Color(0xFF737373),
//                   fontFamily: 'Poppins',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Search Bar Widget
//   Widget _buildSearchBar() {
//     return Container(
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE5E5E7)),
//       ),
//       child: Row(
//         children: [
//           const SizedBox(width: 12),
//           const Icon(
//             Icons.search,
//             size: 20,
//             color: Color(0xFF737373),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: TextField(
//               controller: _searchController,
//               decoration: const InputDecoration(
//                 hintText: 'Search complaints..',
//                 hintStyle: TextStyle(
//                   color: Color(0xFF737373),
//                   fontFamily: 'Poppins',
//                 ),
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.zero,
//               ),
//               style: const TextStyle(
//                 fontFamily: 'Poppins',
//                 color: Color(0xFF1A1A1A),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.filter_list, size: 20),
//             color: const Color(0xFF22C55E),
//             onPressed: () {
//               // Handle filter
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // Filter Tabs Widget
//   Widget _buildFilterTabs() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: _filterButtons.map((filter) {
//           final isSelected = _selectedFilter == filter['value'];
//           return Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: GestureDetector(
//               onTap: () => setState(() => _selectedFilter = filter['value']!),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? const Color(0xFF22C55E)
//                       : const Color(0xFFF5F5F5),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   filter['label']!,
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontFamily: 'Poppins',
//                     color: isSelected ? Colors.white : const Color(0xFF1A1A1A),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   // Complaints List Widget
//   Widget _buildComplaintsList() {
//     if (_isLoading) {
//       return Column(
//         children: [
//           _buildComplaintCardSkeleton(),
//           const SizedBox(height: 12),
//           _buildComplaintCardSkeleton(),
//           const SizedBox(height: 12),
//           _buildComplaintCardSkeleton(),
//         ],
//       );
//     }

//     if (_filteredComplaints.isEmpty) {
//       return Container(
//         padding: const EdgeInsets.all(40),
//         child: const Column(
//           children: [
//             Icon(
//               Icons.report_problem,
//               size: 64,
//               color: Color(0xFFD4D4D4),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'No complaints found',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Color(0xFF737373),
//                 fontFamily: 'Poppins',
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return Column(
//       children: _filteredComplaints
//           .map((complaint) => _buildComplaintCard(complaint))
//           .toList(),
//     );
//   }

//   // Complaint Card Skeleton Widget
//   Widget _buildComplaintCardSkeleton() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE5E5E7)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Top row skeleton
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 80,
//                       height: 24,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF5F5F5),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Container(
//                       width: 64,
//                       height: 24,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF5F5F5),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   width: 80,
//                   height: 24,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF5F5F5),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),

//             // Middle section skeleton
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 200,
//                   height: 20,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF5F5F5),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   width: 160,
//                   height: 16,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF5F5F5),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),

//             // Bottom row skeleton
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: 100,
//                   height: 16,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF5F5F5),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//                 Container(
//                   width: 112,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF5F5F5),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Single Complaint Card Widget
//   Widget _buildComplaintCard(Complaint complaint) {
//     final categoryColor =
//         _categoryColors[complaint.category] ?? _categoryColors['Electricity']!;
//     final statusColor =
//         _statusColors[complaint.status] ?? _statusColors['pending']!;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE5E5E7)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Top row: Category badges and Status
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Category badges
//                 Row(
//                   children: [
//                     // Category badge
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: categoryColor['background'],
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: categoryColor['border']!),
//                       ),
//                       child: Text(
//                         complaint.category,
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: categoryColor['text'],
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),

//                     // ID badge
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 6),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF22C55E).withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(
//                             color: const Color(0xFF22C55E).withOpacity(0.2)),
//                       ),
//                       child: Text(
//                         complaint.id,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xFF22C55E),
//                           fontFamily: 'Poppins',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 // Status badge
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: statusColor['background'],
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: statusColor['border']!),
//                   ),
//                   child: Text(
//                     _formatStatus(complaint.status),
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: statusColor['text'],
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),

//             // Property and Location
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   complaint.property,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Poppins',
//                     color: Color(0xFF1A1A1A),
//                   ),
//                 ),
//                 const SizedBox(height: 4),

//                 // Location with icon
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.location_on,
//                       size: 16,
//                       color: const Color(0xFF737373),
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       complaint.location,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF737373),
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),

//             // Bottom row: Date and View Details button
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Date
//                 Text(
//                   complaint.date,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF737373),
//                     fontFamily: 'Poppins',
//                   ),
//                 ),

//                 // View Details button
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     color: const Color(0xFF22C55E),
//                   ),
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () {
//                         // Navigate to complaint details
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => ComplaintDetailScreen(
//                               complaint: complaint,
//                             ),
//                           ),
//                         );
//                       },
//                       borderRadius: BorderRadius.circular(16),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 10),
//                         child: const Text(
//                           'View details',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                             fontFamily: 'Poppins',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper method to format status text
//   String _formatStatus(String status) {
//     if (status == 'in-progress') return 'In-progress';
//     return status[0].toUpperCase() + status.substring(1);
//   }
// }

// // ============================================
// // COMPLAINT DETAIL SCREEN (ADDED BELOW)
// // ============================================
// class ComplaintDetail {
//   final String id;
//   final String status;
//   final String category;
//   final String property;
//   final String location;
//   final String tenantName;
//   final String tenantPhone;
//   final String description;
//   final String date;

//   const ComplaintDetail({
//     required this.id,
//     required this.status,
//     required this.category,
//     required this.property,
//     required this.location,
//     required this.tenantName,
//     required this.tenantPhone,
//     required this.description,
//     required this.date,
//   });
// }

// class ComplaintDetailScreen extends StatefulWidget {
//   final Complaint complaint;

//   const ComplaintDetailScreen({super.key, required this.complaint});

//   @override
//   State<ComplaintDetailScreen> createState() => _ComplaintDetailScreenState();
// }

// class _ComplaintDetailScreenState extends State<ComplaintDetailScreen> {
//   final TextEditingController _notesController = TextEditingController();
//   String? _selectedTechnician;
//   DrawerItem _activeDrawerItem = DrawerItem.complaints;

//   // Technician options
//   final List<Map<String, String>> _technicians = [
//     {'id': 'tech1', 'name': 'Ahmed Hassan - Electrician'},
//     {'id': 'tech2', 'name': 'Mohamed Ali - Plumber'},
//     {'id': 'tech3', 'name': 'Abdi Mohamed - AC Technician'},
//   ];

//   // Colors for complaint status
//   Map<String, Map<String, Color>> get _statusColors => {
//         'pending': {
//           'background': const Color(0xFFFEF3C7),
//           'text': const Color(0xFF92400E),
//           'border': const Color(0xFFFCD34D),
//         },
//         'in-progress': {
//           'background': const Color(0xFFDBEAFE),
//           'text': const Color(0xFF1E40AF),
//           'border': const Color(0xFF93C5FD),
//         },
//         'resolved': {
//           'background': const Color(0xFFD1FAE5),
//           'text': const Color(0xFF065F46),
//           'border': const Color(0xFF86EFAC),
//         },
//       };

//   // Colors for complaint categories
//   Map<String, Map<String, Color>> get _categoryColors => {
//         'Electricity': {
//           'background': const Color(0xFFFFF7ED),
//           'text': const Color(0xFFC2410C),
//           'border': const Color(0xFFFDBA74),
//         },
//         'AC': {
//           'background': const Color(0xFFEFF6FF),
//           'text': const Color(0xFF1D4ED8),
//           'border': const Color(0xFF93C5FD),
//         },
//         'Plumbing': {
//           'background': const Color(0xFFECFEFF),
//           'text': const Color(0xFF0E7490),
//           'border': const Color(0xFF67E8F9),
//         },
//       };

//   @override
//   Widget build(BuildContext context) {
//     final statusColor =
//         _statusColors[widget.complaint.status] ?? _statusColors['pending']!;
//     final categoryColor = _categoryColors[widget.complaint.category] ??
//         _categoryColors['Electricity']!;

//     return Scaffold(
//       backgroundColor: const Color(0xFFFAFAFA),
//       appBar: _buildAppBar(),
//       drawer: CustomAppBar.buildDrawer(context, _activeDrawerItem, (item) {
//         setState(() => _activeDrawerItem = item);
//       }),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Complaint ID & Status (2 columns)
//               _buildComplaintIdAndStatus(statusColor),
//               const SizedBox(height: 20),

//               // Category
//               _buildCategorySection(categoryColor),
//               const SizedBox(height: 20),

//               // Property
//               _buildPropertySection(),
//               const SizedBox(height: 20),

//               // Tenant
//               _buildTenantSection(),
//               const SizedBox(height: 20),

//               // Description
//               _buildDescriptionSection(),
//               const SizedBox(height: 20),

//               // Assign Technician
//               _buildTechnicianSection(),
//               const SizedBox(height: 20),

//               // Resolution Notes
//               _buildResolutionNotes(),
//               const SizedBox(height: 24),

//               // Action Button
//               _buildActionButton(),
//               const SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // AppBar Widget
//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       backgroundColor: const Color(0xFFFAFAFA),
//       elevation: 0,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A), size: 24),
//         onPressed: () => Navigator.pop(context),
//       ),
//       title: const Text(
//         'Complaint Details',
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//           fontFamily: 'Poppins',
//           color: Color(0xFF1A1A1A),
//         ),
//       ),
//       centerTitle: false,
//     );
//   }

//   // Complaint ID & Status Widget (2 columns)
//   Widget _buildComplaintIdAndStatus(Map<String, Color> statusColor) {
//     return Row(
//       children: [
//         // Complaint ID Column
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     width: 24,
//                     height: 24,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF22C55E).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         '📋',
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   const Text(
//                     'Complaint ID',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF22C55E),
//                       fontFamily: 'Poppins',
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 widget.complaint.id,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Poppins',
//                   color: Color(0xFF1A1A1A),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Status Column
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Status',
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF22C55E),
//                   fontFamily: 'Poppins',
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: statusColor['background'],
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(color: statusColor['border']!),
//                 ),
//                 child: Text(
//                   _formatStatus(widget.complaint.status),
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     color: statusColor['text'],
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Category Section Widget
//   Widget _buildCategorySection(Map<String, Color> categoryColor) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Category',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF22C55E),
//             fontFamily: 'Poppins',
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           decoration: BoxDecoration(
//             color: categoryColor['background'],
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: categoryColor['border']!),
//           ),
//           child: Text(
//             widget.complaint.category,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: categoryColor['text'],
//               fontFamily: 'Poppins',
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Property Section Widget
//   Widget _buildPropertySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Property',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF22C55E),
//             fontFamily: 'Poppins',
//           ),
//         ),
//         const SizedBox(height: 8),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.complaint.property,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: 'Poppins',
//                 color: Color(0xFF1A1A1A),
//               ),
//             ),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 const Icon(
//                   Icons.location_on,
//                   size: 16,
//                   color: Color(0xFF737373),
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   widget.complaint.location,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF737373),
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   // Tenant Section Widget
//   Widget _buildTenantSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Tenant',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF22C55E),
//             fontFamily: 'Poppins',
//           ),
//         ),
//         const SizedBox(height: 8),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Said-Omar ahmed', // Mock tenant name
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: 'Poppins',
//                 color: Color(0xFF1A1A1A),
//               ),
//             ),
//             const SizedBox(height: 4),
//             Row(
//               children: [
//                 const Icon(
//                   Icons.phone,
//                   size: 16,
//                   color: Color(0xFF737373),
//                 ),
//                 const SizedBox(width: 4),
//                 Text(
//                   '+252 614465608', // Mock phone number
//                   style: const TextStyle(
//                     fontSize: 14,
//                     color: Color(0xFF737373),
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   // Description Section Widget
//   Widget _buildDescriptionSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Description',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF22C55E),
//             fontFamily: 'Poppins',
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           'Power outage in apartment for 2 days Power outage in apartment for 2 days', // Mock description
//           style: const TextStyle(
//             fontSize: 14,
//             color: Color(0xFF737373),
//             fontFamily: 'Poppins',
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }

//   // Technician Section Widget
//   Widget _buildTechnicianSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Assign Technician',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             fontFamily: 'Poppins',
//             color: Color(0xFF1A1A1A),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: const Color(0xFFE5E5E7)),
//           ),
//           child: Material(
//             color: Colors.transparent,
//             child: InkWell(
//               onTap: () => _showTechnicianMenu(context),
//               borderRadius: BorderRadius.circular(16),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       _selectedTechnician != null
//                           ? _technicians.firstWhere(
//                               (t) => t['id'] == _selectedTechnician)['name']!
//                           : 'Select technician',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: _selectedTechnician != null
//                             ? const Color(0xFF1A1A1A)
//                             : const Color(0xFF737373),
//                         fontFamily: 'Poppins',
//                       ),
//                     ),
//                     const Icon(
//                       Icons.keyboard_arrow_down,
//                       size: 20,
//                       color: Color(0xFF737373),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Resolution Notes Widget
//   Widget _buildResolutionNotes() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Resolution Notes',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             fontFamily: 'Poppins',
//             color: Color(0xFF1A1A1A),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             border: Border.all(color: const Color(0xFFE5E5E7)),
//           ),
//           child: TextField(
//             controller: _notesController,
//             maxLines: 4,
//             decoration: const InputDecoration(
//               hintText: 'Add resolution notes...',
//               hintStyle: TextStyle(
//                 color: Color(0xFF737373),
//                 fontFamily: 'Poppins',
//               ),
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.all(16),
//             ),
//             style: const TextStyle(
//               fontFamily: 'Poppins',
//               color: Color(0xFF1A1A1A),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Action Button Widget
//   Widget _buildActionButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 48,
//       child: ElevatedButton(
//         onPressed: () {
//           // Handle mark as in-progress
//           print('Marking complaint as in-progress');
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF22C55E),
//           foregroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 0,
//         ),
//         child: const Text(
//           'Mark In Progress',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             fontFamily: 'Poppins',
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper Methods
//   String _formatStatus(String status) {
//     if (status == 'in-progress') return 'In-progress';
//     return status[0].toUpperCase() + status.substring(1);
//   }

//   void _showTechnicianMenu(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Select Technician',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 fontFamily: 'Poppins',
//               ),
//             ),
//             const SizedBox(height: 16),
//             ..._technicians
//                 .map((tech) => ListTile(
//                       title: Text(
//                         tech['name']!,
//                         style: const TextStyle(fontFamily: 'Poppins'),
//                       ),
//                       trailing: _selectedTechnician == tech['id']
//                           ? const Icon(Icons.check, color: Color(0xFF22C55E))
//                           : null,
//                       onTap: () {
//                         setState(() => _selectedTechnician = tech['id']);
//                         Navigator.pop(context);
//                       },
//                     ))
//                 .toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
