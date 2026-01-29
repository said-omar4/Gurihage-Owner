// lib/presentation/screens/analytics_screen.dart
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
      title: 'Analytics',
      theme: ThemeData(
        primaryColor: const Color(0xFF22C55E),
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      ),
      debugShowCheckedModeBanner: false,
      home: const AnalyticsScreen(),
    );
  }
}

// ============================================
// DATA MODELS
// ============================================
class ChartData {
  final String label;
  final double earnings;

  ChartData({
    required this.label,
    required this.earnings,
  });
}

class OccupancyData {
  final String name;
  final double occupancy;
  final int tenants;

  OccupancyData({
    required this.name,
    required this.occupancy,
    required this.tenants,
  });
}

class PerformanceData {
  final String name;
  final double earnings;
  final double percentage;

  PerformanceData({
    required this.name,
    required this.earnings,
    required this.percentage,
  });
}

// Colors for charts
const List<Color> chartColors = [
  Color(0xFF22C55E), // #19B65B
  Color(0xFF3B82F6), // Blue
  Color(0xFFEF4444), // Red
  Color(0xFFF59E0B), // Orange
  Color(0xFF8B5CF6), // Purple
];

// ============================================
// ANALYTICS SCREEN (NO TABS - SECTIONS IN LINE)
// ============================================
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  // Mock data matching your React data
  final double _totalEarnings = 12540.75;
  final int _propertyCount = 8;
  final int _activeTenants = 24;
  final double _avgOccupancy = 85.5;

  final List<ChartData> _earningsChartData = [
    ChartData(label: 'Jan', earnings: 3200),
    ChartData(label: 'Feb', earnings: 2800),
    ChartData(label: 'Mar', earnings: 3500),
    ChartData(label: 'Apr', earnings: 4200),
    ChartData(label: 'May', earnings: 3800),
    ChartData(label: 'Jun', earnings: 4500),
  ];

  final List<OccupancyData> _occupancyData = [
    OccupancyData(name: 'Dahab Tower', occupancy: 100, tenants: 12),
    OccupancyData(name: 'Sky Garden', occupancy: 85, tenants: 8),
    OccupancyData(name: 'Ocean View', occupancy: 75, tenants: 4),
    OccupancyData(name: 'City Center', occupancy: 90, tenants: 10),
  ];

  final List<PerformanceData> _performanceData = [
    PerformanceData(name: 'Dahab Tower', earnings: 7500, percentage: 60),
    PerformanceData(name: 'Sky Garden', earnings: 3500, percentage: 28),
    PerformanceData(name: 'Ocean View', earnings: 1540.75, percentage: 12),
  ];

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
              // Header
              _buildHeader(),
              const SizedBox(height: 20),

              // KPI Cards
              _buildKpiCards(),
              const SizedBox(height: 20),

              // ============================================
              // SECTION 1: EARNINGS CHART
              // ============================================
              _buildSectionTitle('Monthly Earnings Trend'),
              const SizedBox(height: 12),
              _buildEarningsChartSection(),
              const SizedBox(height: 24),

              // ============================================
              // SECTION 2: OCCUPANCY CHART
              // ============================================
              _buildSectionTitle('Property Occupancy Rates'),
              const SizedBox(height: 12),
              _buildOccupancyChartSection(),
              const SizedBox(height: 24),

              // ============================================
              // SECTION 3: PERFORMANCE CHART
              // ============================================
              _buildSectionTitle('Property Performance Distribution'),
              const SizedBox(height: 12),
              _buildPerformanceChartSection(),
              const SizedBox(height: 24),

              // ============================================
              // SECTION 4: PROPERTY PERFORMANCE LIST
              // ============================================
              _buildSectionTitle('Property Performance Details'),
              const SizedBox(height: 12),
              _buildPropertyPerformanceList(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Header Widget
  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Analytics Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
            color: Color(0xFF1A1A1A),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Comprehensive performance metrics',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF737373),
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  // Section Title Widget
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
        color: Color(0xFF1A1A1A),
      ),
    );
  }

  // KPI Cards Widget
  Widget _buildKpiCards() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        // Total Revenue Card
        _buildKpiCard(
          value: '\$${_totalEarnings.toStringAsFixed(0)}',
          label: 'Total Revenue',
          icon: Icons.attach_money,
        ),

        // Properties Card
        _buildKpiCard(
          value: '$_propertyCount',
          label: 'Properties',
          icon: Icons.home,
        ),

        // Active Tenants Card
        _buildKpiCard(
          value: '$_activeTenants',
          label: 'Active Tenants',
          icon: Icons.people,
        ),

        // Avg Occupancy Card
        _buildKpiCard(
          value: '${_avgOccupancy.toStringAsFixed(0)}%',
          label: 'Avg Occupancy',
          icon: Icons.trending_up,
        ),
      ],
    );
  }

  // Single KPI Card Widget
  Widget _buildKpiCard({
    required String value,
    required String label,
    required IconData icon,
  }) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF22C55E),
                    fontFamily: 'Poppins',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: const Color(0xFF22C55E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF737373),
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Earnings Chart Section Widget
  Widget _buildEarningsChartSection() {
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
            // Custom Chart
            _buildLineChart(),
            const SizedBox(height: 16),

            // Chart Summary
            _buildChartSummary(
              title: 'Monthly Earnings',
              value: '\$${_totalEarnings.toStringAsFixed(2)}',
              period: 'Last 6 months',
            ),
          ],
        ),
      ),
    );
  }

  // Occupancy Chart Section Widget
  Widget _buildOccupancyChartSection() {
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
            // Custom Bar Chart
            _buildBarChart(),
            const SizedBox(height: 16),

            // Chart Summary
            _buildChartSummary(
              title: 'Average Occupancy',
              value: '${_avgOccupancy.toStringAsFixed(1)}%',
              period: 'Across ${_propertyCount} properties',
            ),
          ],
        ),
      ),
    );
  }

  // Performance Chart Section Widget
  Widget _buildPerformanceChartSection() {
    final totalEarnings =
        _performanceData.fold(0.0, (sum, item) => sum + item.earnings);

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
            // Custom Pie Chart
            _buildPieChart(),
            const SizedBox(height: 16),

            // Chart Summary
            _buildChartSummary(
              title: 'Total Performance',
              value: '\$${totalEarnings.toStringAsFixed(0)}',
              period: '${_performanceData.length} properties',
            ),
          ],
        ),
      ),
    );
  }

  // Chart Summary Widget
  Widget _buildChartSummary({
    required String title,
    required String value,
    required String period,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF737373),
                fontFamily: 'Poppins',
              ),
            ),
            Text(
              period,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFA3A3A3),
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF22C55E),
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  // Property Performance List Widget
  Widget _buildPropertyPerformanceList() {
    return Column(
      children: _performanceData.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return _buildPropertyPerformanceCard(item, index);
      }).toList(),
    );
  }

  // Property Performance Card Widget
  Widget _buildPropertyPerformanceCard(PerformanceData item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5E7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: chartColors[index % chartColors.length],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    Text(
                      '${item.percentage.toStringAsFixed(1)}% of total',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF737373),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '\$${item.earnings.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF22C55E),
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Line Chart Widget (Simplified)
  Widget _buildLineChart() {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          // Y-axis labels
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  width: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('5k',
                          style: TextStyle(
                              fontSize: 10, color: Color(0xFF737373))),
                      Text('4k',
                          style: TextStyle(
                              fontSize: 10, color: Color(0xFF737373))),
                      Text('3k',
                          style: TextStyle(
                              fontSize: 10, color: Color(0xFF737373))),
                      Text('2k',
                          style: TextStyle(
                              fontSize: 10, color: Color(0xFF737373))),
                      Text('1k',
                          style: TextStyle(
                              fontSize: 10, color: Color(0xFF737373))),
                      Text('0',
                          style: TextStyle(
                              fontSize: 10, color: Color(0xFF737373))),
                    ],
                  ),
                ),

                // Chart area
                Expanded(
                  child: Stack(
                    children: [
                      // Grid lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            6,
                            (index) => Container(
                                  height: 1,
                                  color: const Color(0xFFE5E5E7),
                                )),
                      ),

                      // Data points and lines
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:
                            _earningsChartData.asMap().entries.map((entry) {
                          final index = entry.key;
                          final data = entry.value;
                          final height = (data.earnings / 5000) * 180;

                          return Column(
                            children: [
                              // Data point
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF22C55E),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(height: 4),

                              // Line segment
                              Container(
                                width: 2,
                                height: height,
                                color: const Color(0xFF22C55E),
                              ),

                              // X-axis label
                              const SizedBox(height: 8),
                              Text(
                                data.label,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF737373),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
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

  // Bar Chart Widget (Simplified)
  Widget _buildBarChart() {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          // Y-axis labels
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  width: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('100%',
                          style: TextStyle(
                              fontSize: 10, color: Color(0xFF737373))),
                      Text('75%',
                          style: TextStyle(
                              fontSize: 10, color: Color(0xFF737373))),
                      Text('50%',
                          style: TextStyle(
                              fontSize: 10, color: Color(0xFF737373))),
                      Text('25%',
                          style: TextStyle(
                              fontSize: 10, color: Color(0xFF737373))),
                      Text('0%',
                          style: TextStyle(
                              fontSize: 10, color: Color(0xFF737373))),
                    ],
                  ),
                ),

                // Chart area
                Expanded(
                  child: Stack(
                    children: [
                      // Grid lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            5,
                            (index) => Container(
                                  height: 1,
                                  color: const Color(0xFFE5E5E7),
                                )),
                      ),

                      // Bars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: _occupancyData.asMap().entries.map((entry) {
                          final data = entry.value;
                          final height = (data.occupancy / 100) * 160;

                          return Column(
                            children: [
                              // Bar
                              Container(
                                width: 40,
                                height: height,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF22C55E),
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(8),
                                  ),
                                ),
                              ),

                              // X-axis label
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 60,
                                child: Text(
                                  data.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFF737373),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
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

  // Pie Chart Widget (Simplified)
  Widget _buildPieChart() {
    final totalEarnings =
        _performanceData.fold(0.0, (sum, item) => sum + item.earnings);

    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pie representation with colored segments
          SizedBox(
            width: 180,
            height: 180,
            child: CustomPaint(
              painter: PieChartPainter(
                data: _performanceData,
                total: totalEarnings,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Legend
          Wrap(
            spacing: 12,
            runSpacing: 6,
            alignment: WrapAlignment.center,
            children: _performanceData.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: chartColors[index % chartColors.length],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF737373),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// Custom Pie Chart Painter
class PieChartPainter extends CustomPainter {
  final List<PerformanceData> data;
  final double total;

  PieChartPainter({
    required this.data,
    required this.total,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    double startAngle = -90 * (3.1415926535 / 180); // Start at top

    for (int i = 0; i < data.length; i++) {
      final item = data[i];
      final sweepAngle = (item.earnings / total) * 360 * (3.1415926535 / 180);

      final paint = Paint()
        ..color = chartColors[i % chartColors.length]
        ..style = PaintingStyle.fill;

      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);

      startAngle += sweepAngle;
    }

    // Draw center circle for donut effect
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.5, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// // lib/presentation/screens/analytics_screen.dart
// import 'package:flutter/material.dart';
// import 'package:xirfadsan_receipt/appbar.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Analytics',
//       theme: ThemeData(
//         primaryColor: const Color(0xFF22C55E),
//         useMaterial3: true,
//         fontFamily: 'Poppins',
//         scaffoldBackgroundColor: const Color(0xFFFAFAFA),
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const AnalyticsScreen(),
//     );
//   }
// }

// // ============================================
// // DATA MODELS
// // ============================================
// class ChartData {
//   final String label;
//   final double earnings;

//   ChartData({
//     required this.label,
//     required this.earnings,
//   });
// }

// class OccupancyData {
//   final String name;
//   final double occupancy;
//   final int tenants;

//   OccupancyData({
//     required this.name,
//     required this.occupancy,
//     required this.tenants,
//   });
// }

// class PerformanceData {
//   final String name;
//   final double earnings;
//   final double percentage;

//   PerformanceData({
//     required this.name,
//     required this.earnings,
//     required this.percentage,
//   });
// }

// // Colors for charts
// const List<Color> chartColors = [
//   Color(0xFF22C55E), // #19B65B
//   Color(0xFF3B82F6), // Blue
//   Color(0xFFEF4444), // Red
//   Color(0xFFF59E0B), // Orange
//   Color(0xFF8B5CF6), // Purple
// ];

// // ============================================
// // ANALYTICS SCREEN
// // ============================================
// class AnalyticsScreen extends StatefulWidget {
//   const AnalyticsScreen({super.key});

//   @override
//   State<AnalyticsScreen> createState() => _AnalyticsScreenState();
// }

// class _AnalyticsScreenState extends State<AnalyticsScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   // Mock data matching your React data
//   final double _totalEarnings = 12540.75;
//   final int _propertyCount = 8;
//   final int _activeTenants = 24;
//   final double _avgOccupancy = 85.5;

//   final List<ChartData> _earningsChartData = [
//     ChartData(label: 'Jan', earnings: 3200),
//     ChartData(label: 'Feb', earnings: 2800),
//     ChartData(label: 'Mar', earnings: 3500),
//     ChartData(label: 'Apr', earnings: 4200),
//     ChartData(label: 'May', earnings: 3800),
//     ChartData(label: 'Jun', earnings: 4500),
//   ];

//   final List<OccupancyData> _occupancyData = [
//     OccupancyData(name: 'Dahab Tower', occupancy: 100, tenants: 12),
//     OccupancyData(name: 'Sky Garden', occupancy: 85, tenants: 8),
//     OccupancyData(name: 'Ocean View', occupancy: 75, tenants: 4),
//     OccupancyData(name: 'City Center', occupancy: 90, tenants: 10),
//   ];

//   final List<PerformanceData> _performanceData = [
//     PerformanceData(name: 'Dahab Tower', earnings: 7500, percentage: 60),
//     PerformanceData(name: 'Sky Garden', earnings: 3500, percentage: 28),
//     PerformanceData(name: 'Ocean View', earnings: 1540.75, percentage: 12),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   int _selectedIndex = 0;
//   DrawerItem _activeDrawerItem = DrawerItem.dashboard;

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
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Header
//               _buildHeader(),
//               const SizedBox(height: 20),

//               // KPI Cards
//               _buildKpiCards(),
//               const SizedBox(height: 20),

//               // Tabs
//               _buildTabs(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Header Widget
//   Widget _buildHeader() {
//     return const Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Analytics Dashboard',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w700,
//             fontFamily: 'Poppins',
//             color: Color(0xFF1A1A1A),
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           'Comprehensive performance metrics',
//           style: TextStyle(
//             fontSize: 14,
//             color: Color(0xFF737373),
//             fontFamily: 'Poppins',
//           ),
//         ),
//       ],
//     );
//   }

//   // KPI Cards Widget
//   Widget _buildKpiCards() {
//     return GridView.count(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       crossAxisCount: 2,
//       mainAxisSpacing: 12,
//       crossAxisSpacing: 12,
//       childAspectRatio: 1.4,
//       children: [
//         // Total Revenue Card
//         _buildKpiCard(
//           value: '\$${_totalEarnings.toStringAsFixed(0)}',
//           label: 'Total Revenue',
//           icon: Icons.attach_money,
//         ),

//         // Properties Card
//         _buildKpiCard(
//           value: '$_propertyCount',
//           label: 'Properties',
//           icon: Icons.home,
//         ),

//         // Active Tenants Card
//         _buildKpiCard(
//           value: '$_activeTenants',
//           label: 'Active Tenants',
//           icon: Icons.people,
//         ),

//         // Avg Occupancy Card
//         _buildKpiCard(
//           value: '${_avgOccupancy.toStringAsFixed(0)}%',
//           label: 'Avg Occupancy',
//           icon: Icons.trending_up,
//         ),
//       ],
//     );
//   }

//   // Single KPI Card Widget
//   Widget _buildKpiCard({
//     required String value,
//     required String label,
//     required IconData icon,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE5E5E7)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF22C55E),
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF22C55E).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     icon,
//                     size: 20,
//                     color: const Color(0xFF22C55E),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Color(0xFF737373),
//                 fontFamily: 'Poppins',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Tabs Widget
//   Widget _buildTabs() {
//     return Column(
//       children: [
//         // Tab Bar
//         Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFFF5F5F5),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: TabBar(
//             controller: _tabController,
//             labelColor: Colors.white,
//             unselectedLabelColor: const Color(0xFF737373),
//             indicator: BoxDecoration(
//               color: const Color(0xFF22C55E),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             tabs: const [
//               Tab(text: 'Earnings'),
//               Tab(text: 'Occupancy'),
//               Tab(text: 'Performance'),
//             ],
//             labelStyle: const TextStyle(
//               fontFamily: 'Poppins',
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),

//         // Tab Content
//         SizedBox(
//           height: 500,
//           child: TabBarView(
//             controller: _tabController,
//             children: [
//               // Earnings Tab
//               _buildEarningsTab(),

//               // Occupancy Tab
//               _buildOccupancyTab(),

//               // Performance Tab
//               _buildPerformanceTab(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // Earnings Tab Widget
//   Widget _buildEarningsTab() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           // Earnings Chart Card
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: const Color(0xFFE5E5E7)),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Monthly Earnings Trend',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Poppins',
//                       color: Color(0xFF1A1A1A),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Custom Chart
//                   _buildLineChart(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Occupancy Tab Widget
//   Widget _buildOccupancyTab() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           // Occupancy Chart Card
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: const Color(0xFFE5E5E7)),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Property Occupancy Rates',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Poppins',
//                       color: Color(0xFF1A1A1A),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Custom Bar Chart
//                   _buildBarChart(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Performance Tab Widget
//   Widget _buildPerformanceTab() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           // Pie Chart Card
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: const Color(0xFFE5E5E7)),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Property Performance Distribution',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: 'Poppins',
//                       color: Color(0xFF1A1A1A),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Custom Pie Chart
//                   _buildPieChart(),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Property List
//           Column(
//             children: _performanceData.asMap().entries.map((entry) {
//               final index = entry.key;
//               final item = entry.value;
//               return _buildPropertyPerformanceCard(item, index);
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   // Line Chart Widget (Simplified)
//   Widget _buildLineChart() {
//     return SizedBox(
//       height: 300,
//       child: Column(
//         children: [
//           // Y-axis labels
//           Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(
//                   width: 40,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('5k',
//                           style: TextStyle(
//                               fontSize: 10, color: Color(0xFF737373))),
//                       Text('4k',
//                           style: TextStyle(
//                               fontSize: 10, color: Color(0xFF737373))),
//                       Text('3k',
//                           style: TextStyle(
//                               fontSize: 10, color: Color(0xFF737373))),
//                       Text('2k',
//                           style: TextStyle(
//                               fontSize: 10, color: Color(0xFF737373))),
//                       Text('1k',
//                           style: TextStyle(
//                               fontSize: 10, color: Color(0xFF737373))),
//                       Text('0',
//                           style: TextStyle(
//                               fontSize: 10, color: Color(0xFF737373))),
//                     ],
//                   ),
//                 ),

//                 // Chart area
//                 Expanded(
//                   child: Stack(
//                     children: [
//                       // Grid lines
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: List.generate(
//                             6,
//                             (index) => Container(
//                                   height: 1,
//                                   color: const Color(0xFFE5E5E7),
//                                 )),
//                       ),

//                       // Data points and lines
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children:
//                             _earningsChartData.asMap().entries.map((entry) {
//                           final index = entry.key;
//                           final data = entry.value;
//                           final height = (data.earnings / 5000) * 200;

//                           return Column(
//                             children: [
//                               // Data point
//                               Container(
//                                 width: 8,
//                                 height: 8,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF22C55E),
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),

//                               // Line segment
//                               Container(
//                                 width: 2,
//                                 height: height,
//                                 color: const Color(0xFF22C55E),
//                               ),

//                               // X-axis label
//                               const SizedBox(height: 8),
//                               Text(
//                                 data.label,
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   color: Color(0xFF737373),
//                                 ),
//                               ),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Bar Chart Widget (Simplified)
//   Widget _buildBarChart() {
//     return SizedBox(
//       height: 300,
//       child: Column(
//         children: [
//           // Y-axis labels
//           Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const SizedBox(
//                   width: 40,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('100%',
//                           style: TextStyle(
//                               fontSize: 10, color: Color(0xFF737373))),
//                       Text('75%',
//                           style: TextStyle(
//                               fontSize: 10, color: Color(0xFF737373))),
//                       Text('50%',
//                           style: TextStyle(
//                               fontSize: 10, color: Color(0xFF737373))),
//                       Text('25%',
//                           style: TextStyle(
//                               fontSize: 10, color: Color(0xFF737373))),
//                       Text('0%',
//                           style: TextStyle(
//                               fontSize: 10, color: Color(0xFF737373))),
//                     ],
//                   ),
//                 ),

//                 // Chart area
//                 Expanded(
//                   child: Stack(
//                     children: [
//                       // Grid lines
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: List.generate(
//                             5,
//                             (index) => Container(
//                                   height: 1,
//                                   color: const Color(0xFFE5E5E7),
//                                 )),
//                       ),

//                       // Bars
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: _occupancyData.asMap().entries.map((entry) {
//                           final data = entry.value;
//                           final height = (data.occupancy / 100) * 180;

//                           return Column(
//                             children: [
//                               // Bar
//                               Container(
//                                 width: 40,
//                                 height: height,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF22C55E),
//                                   borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(8),
//                                   ),
//                                 ),
//                               ),

//                               // X-axis label
//                               const SizedBox(height: 8),
//                               SizedBox(
//                                 width: 60,
//                                 child: Text(
//                                   data.name,
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                     fontSize: 10,
//                                     color: Color(0xFF737373),
//                                   ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Pie Chart Widget (Simplified)
//   Widget _buildPieChart() {
//     final totalEarnings =
//         _performanceData.fold(0.0, (sum, item) => sum + item.earnings);

//     return SizedBox(
//       height: 300,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Pie representation with colored segments
//           SizedBox(
//             width: 200,
//             height: 200,
//             child: CustomPaint(
//               painter: PieChartPainter(
//                 data: _performanceData,
//                 total: totalEarnings,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),

//           // Legend
//           Wrap(
//             spacing: 16,
//             runSpacing: 8,
//             alignment: WrapAlignment.center,
//             children: _performanceData.asMap().entries.map((entry) {
//               final index = entry.key;
//               final item = entry.value;
//               return Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     width: 12,
//                     height: 12,
//                     decoration: BoxDecoration(
//                       color: chartColors[index % chartColors.length],
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   const SizedBox(width: 4),
//                   Text(
//                     item.name,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Color(0xFF737373),
//                     ),
//                   ),
//                 ],
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   // Property Performance Card Widget
//   Widget _buildPropertyPerformanceCard(PerformanceData item, int index) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE5E5E7)),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 16,
//                   height: 16,
//                   decoration: BoxDecoration(
//                     color: chartColors[index % chartColors.length],
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Text(
//                   item.name,
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Poppins',
//                     color: Color(0xFF1A1A1A),
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   '\$${item.earnings.toStringAsFixed(0)}',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFF22C55E),
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   '${item.percentage.toStringAsFixed(1)}%',
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF737373),
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Custom Pie Chart Painter
// class PieChartPainter extends CustomPainter {
//   final List<PerformanceData> data;
//   final double total;

//   PieChartPainter({
//     required this.data,
//     required this.total,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2;

//     double startAngle = -90 * (3.1415926535 / 180); // Start at top

//     for (int i = 0; i < data.length; i++) {
//       final item = data[i];
//       final sweepAngle = (item.earnings / total) * 360 * (3.1415926535 / 180);

//       final paint = Paint()
//         ..color = chartColors[i % chartColors.length]
//         ..style = PaintingStyle.fill;

//       final rect = Rect.fromCircle(center: center, radius: radius);
//       canvas.drawArc(rect, startAngle, sweepAngle, true, paint);

//       startAngle += sweepAngle;
//     }

//     // Draw center circle for donut effect
//     final centerPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;

//     canvas.drawCircle(center, radius * 0.5, centerPaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
