// lib/presentation/screens/complaint_details.dart
import 'package:flutter/material.dart';
import 'package:xirfadsan_receipt/appbar.dart';

// ============================================
// COMPLAINT DETAIL MODEL
// ============================================
class ComplaintDetail {
  final String id;
  final String status;
  final String category;
  final String property;
  final String location;
  final String tenantName;
  final String tenantPhone;
  final String description;
  final String date;

  const ComplaintDetail({
    required this.id,
    required this.status,
    required this.category,
    required this.property,
    required this.location,
    required this.tenantName,
    required this.tenantPhone,
    required this.description,
    required this.date,
  });
}

// ============================================
// COMPLAINT DETAIL SCREEN
// ============================================
class ComplaintDetailScreen extends StatefulWidget {
  final String complaintId;

  const ComplaintDetailScreen({super.key, required this.complaintId});

  @override
  State<ComplaintDetailScreen> createState() => _ComplaintDetailScreenState();
}

class _ComplaintDetailScreenState extends State<ComplaintDetailScreen> {
  final TextEditingController _notesController = TextEditingController();
  String? _selectedTechnician;
  DrawerItem _activeDrawerItem = DrawerItem.complaints;

  // Technician options
  final List<Map<String, String>> _technicians = [
    {'id': 'tech1', 'name': 'Ahmed Hassan - Electrician'},
    {'id': 'tech2', 'name': 'Mohamed Ali - Plumber'},
    {'id': 'tech3', 'name': 'Abdi Mohamed - AC Technician'},
  ];

  // Get complaint data based on ID
  ComplaintDetail get _complaint {
    // In real app, fetch from API based on widget.complaintId
    // Here using mock data
    return ComplaintDetail(
      id: widget.complaintId,
      status: "pending",
      category: "Electricity",
      property: "Studio Cozy Studio Near Park",
      location: "Banaadir mogadishu somalia",
      tenantName: "Said-Omar ahmed",
      tenantPhone: "+252 614465608",
      description:
          "Power outage in apartment for 2 days Power outage in apartment for 2 days",
      date: "2024-01-15",
    );
  }

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

  @override
  Widget build(BuildContext context) {
    final statusColor =
        _statusColors[_complaint.status] ?? _statusColors['pending']!;
    final categoryColor =
        _categoryColors[_complaint.category] ?? _categoryColors['Electricity']!;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: _buildAppBar(),
      drawer: CustomAppBar.buildDrawer(context, _activeDrawerItem, (item) {
        setState(() => _activeDrawerItem = item);
      }),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Complaint ID & Status (2 columns)
              _buildComplaintIdAndStatus(statusColor),
              const SizedBox(height: 20),

              // Category
              _buildCategorySection(categoryColor),
              const SizedBox(height: 20),

              // Property
              _buildPropertySection(),
              const SizedBox(height: 20),

              // Tenant
              _buildTenantSection(),
              const SizedBox(height: 20),

              // Description
              _buildDescriptionSection(),
              const SizedBox(height: 20),

              // Assign Technician
              _buildTechnicianSection(),
              const SizedBox(height: 20),

              // Resolution Notes
              _buildResolutionNotes(),
              const SizedBox(height: 24),

              // Action Button
              _buildActionButton(),
              const SizedBox(height: 32),
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
        'Complaint Details',
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

  // Complaint ID & Status Widget (2 columns)
  Widget _buildComplaintIdAndStatus(Map<String, Color> statusColor) {
    return Row(
      children: [
        // Complaint ID Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Center(
                      child: Text(
                        '📋',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Complaint ID',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF22C55E),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _complaint.id,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        ),

        // Status Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Status',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF22C55E),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor['background'],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor['border']!),
                ),
                child: Text(
                  _formatStatus(_complaint.status),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: statusColor['text'],
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Category Section Widget
  Widget _buildCategorySection(Map<String, Color> categoryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF22C55E),
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: categoryColor['background'],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: categoryColor['border']!),
          ),
          child: Text(
            _complaint.category,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: categoryColor['text'],
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }

  // Property Section Widget
  Widget _buildPropertySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Property',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF22C55E),
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _complaint.property,
              style: const TextStyle(
                fontSize: 18,
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
                  size: 16,
                  color: Color(0xFF737373),
                ),
                const SizedBox(width: 4),
                Text(
                  _complaint.location,
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
      ],
    );
  }

  // Tenant Section Widget
  Widget _buildTenantSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tenant',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF22C55E),
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _complaint.tenantName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  size: 16,
                  color: Color(0xFF737373),
                ),
                const SizedBox(width: 4),
                Text(
                  _complaint.tenantPhone,
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
      ],
    );
  }

  // Description Section Widget
  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF22C55E),
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _complaint.description,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF737373),
            fontFamily: 'Poppins',
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // Technician Section Widget
  Widget _buildTechnicianSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Assign Technician',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E5E7)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showTechnicianMenu(context),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedTechnician != null
                          ? _technicians.firstWhere(
                              (t) => t['id'] == _selectedTechnician)['name']!
                          : 'Select technician',
                      style: TextStyle(
                        fontSize: 16,
                        color: _selectedTechnician != null
                            ? const Color(0xFF1A1A1A)
                            : const Color(0xFF737373),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Color(0xFF737373),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Resolution Notes Widget
  Widget _buildResolutionNotes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Resolution Notes',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E5E7)),
          ),
          child: TextField(
            controller: _notesController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Add resolution notes...',
              hintStyle: TextStyle(
                color: Color(0xFF737373),
                fontFamily: 'Poppins',
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),
      ],
    );
  }

  // Action Button Widget
  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          // Handle mark as in-progress
          print('Marking complaint as in-progress');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF22C55E),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Mark In Progress',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }

  // Helper Methods
  String _formatStatus(String status) {
    if (status == 'in-progress') return 'In-progress';
    return status[0].toUpperCase() + status.substring(1);
  }

  void _showTechnicianMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Technician',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),
            ..._technicians
                .map((tech) => ListTile(
                      title: Text(
                        tech['name']!,
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      trailing: _selectedTechnician == tech['id']
                          ? const Icon(Icons.check, color: Color(0xFF22C55E))
                          : null,
                      onTap: () {
                        setState(() => _selectedTechnician = tech['id']);
                        Navigator.pop(context);
                      },
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}

// // lib/presentation/screens/complaint_detail_screen.dart
// import 'package:flutter/material.dart';
// import 'package:xirfadsan_receipt/appbar.dart';

// // ============================================
// // COMPLAINT DETAIL MODEL
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

// // ============================================
// // COMPLAINT DETAIL SCREEN
// // ============================================
// class ComplaintDetailScreen extends StatefulWidget {
//   const ComplaintDetailScreen({super.key});

//   @override
//   State<ComplaintDetailScreen> createState() => _ComplaintDetailScreenState();
// }

// class _ComplaintDetailScreenState extends State<ComplaintDetailScreen> {
//   final TextEditingController _notesController = TextEditingController();
//   String? _selectedTechnician;
//   DrawerItem _activeDrawerItem = DrawerItem.complaints;

//   // Mock complaint data
//   final ComplaintDetail _complaint = const ComplaintDetail(
//     id: "C001111",
//     status: "pending",
//     category: "Electricity",
//     property: "Studio Cozy Studio Near Park",
//     location: "Banaadir mogadishu somalia",
//     tenantName: "Said-Omar ahmed",
//     tenantPhone: "+252 614465608",
//     description:
//         "Power outage in apartment for 2 days Power outage in apartment for 2 days",
//     date: "2024-01-15",
//   );

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
//         _statusColors[_complaint.status] ?? _statusColors['pending']!;
//     final categoryColor =
//         _categoryColors[_complaint.category] ?? _categoryColors['Electricity']!;

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
//                 _complaint.id,
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
//                   _formatStatus(_complaint.status),
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
//             _complaint.category,
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
//               _complaint.property,
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
//                   _complaint.location,
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
//               _complaint.tenantName,
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
//                   _complaint.tenantPhone,
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
//           _complaint.description,
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
