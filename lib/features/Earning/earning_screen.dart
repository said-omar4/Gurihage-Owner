// lib/presentation/screens/earnings_screen.dart
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
      title: 'Earnings',
      theme: ThemeData(
        primaryColor: const Color(0xFF22C55E),
        useMaterial3: true,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      ),
      debugShowCheckedModeBanner: false,
      home: const EarningsScreen(),
    );
  }
}

// ============================================
// DATA MODELS
// ============================================
class ChartData {
  final String label;
  final double earnings;
  final double secondary;

  ChartData({
    required this.label,
    required this.earnings,
    required this.secondary,
  });
}

class PropertyBreakdown {
  final String name;
  final double amount;
  final double percentage;

  PropertyBreakdown({
    required this.name,
    required this.amount,
    required this.percentage,
  });
}

class EarningsData {
  final double totalEarnings;
  final List<ChartData> chartData;
  final List<PropertyBreakdown> propertyBreakdown;

  EarningsData({
    required this.totalEarnings,
    required this.chartData,
    required this.propertyBreakdown,
  });
}

// Time Filter Enum
enum TimeFilter { weekly, monthly, yearly }

// ============================================
// EARNINGS SCREEN
// ============================================
class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  TimeFilter _timeFilter = TimeFilter.monthly;
  bool _isLoading = false;

  // Mock data matching your React data
  final EarningsData _earningsData = EarningsData(
    totalEarnings: 12540.75,
    chartData: [
      ChartData(label: 'Jan', earnings: 3200, secondary: 2800),
      ChartData(label: 'Feb', earnings: 2800, secondary: 2500),
      ChartData(label: 'Mar', earnings: 3500, secondary: 3000),
      ChartData(label: 'Apr', earnings: 4200, secondary: 3500),
      ChartData(label: 'May', earnings: 3800, secondary: 3200),
      ChartData(label: 'Jun', earnings: 4500, secondary: 3800),
    ],
    propertyBreakdown: [
      PropertyBreakdown(name: 'Dahab Tower', amount: 7500, percentage: 60),
      PropertyBreakdown(name: 'Sky Garden', amount: 3500, percentage: 28),
      PropertyBreakdown(name: 'Ocean View', amount: 1540.75, percentage: 12),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Export Buttons
              _buildExportButtons(),
              const SizedBox(height: 20),

              // Loading State
              if (_isLoading) _buildLoadingState(),

              // Total Earning Card
              if (!_isLoading) _buildTotalEarningCard(),
              const SizedBox(height: 20),

              // Earnings Chart Section
              if (!_isLoading) _buildEarningsChart(),
              const SizedBox(height: 20),

              // Earnings by Property
              if (!_isLoading) _buildPropertyEarnings(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Export Buttons Widget
  Widget _buildExportButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // CSV Export Button
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5E5E7)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _handleExport('csv'),
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.download,
                      size: 16,
                      color: Color(0xFF1A1A1A),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Export CSV',
                      style: TextStyle(
                        fontSize: 14,
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
        const SizedBox(width: 8),

        // JSON Export Button
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5E5E7)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _handleExport('json'),
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.download,
                      size: 16,
                      color: Color(0xFF1A1A1A),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Export JSON',
                      style: TextStyle(
                        fontSize: 14,
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
      ],
    );
  }

  // Loading State Widget
  Widget _buildLoadingState() {
    return Container(
      height: 400,
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 48,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF22C55E)),
              strokeWidth: 2,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Loading earnings data...',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF737373),
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  // Total Earning Card Widget
  Widget _buildTotalEarningCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // Color(0xFF22C55E).withOpacity(0.05),
            Color(0xFF22C55E),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            // Dollar Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.attach_money,
                size: 32,
                color: Color(0xFF22C55E),
              ),
            ),
            const SizedBox(width: 16),

            // Total Amount
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Earning',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF737373),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${_earningsData.totalEarnings.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF22C55E),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Earnings Chart Widget
  Widget _buildEarningsChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        const Text(
          'Earnings Overview',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 16),

        // Chart Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E5E7)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Chart Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Earnings',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xFF1A1A1A),
                      ),
                    ),

                    // Time Filter Dropdown
                    Container(
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE5E5E7)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _showTimeFilterMenu(context),
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 16,
                                  color: Color(0xFF737373),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _timeFilter.toString().split('.').last,
                                  style: const TextStyle(
                                    fontSize: 14,
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
                  ],
                ),
                const SizedBox(height: 20),

                // Custom Chart (Simplified - Use charts_flutter for real charts)
                _buildCustomChart(),
                const SizedBox(height: 16),

                // Chart Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_timeFilter.toString().split('.').last} View',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF737373),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      '\$${_earningsData.totalEarnings.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Custom Chart Widget (Simplified)
  Widget _buildCustomChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Y-axis labels
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Y-axis
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
                        children: _earningsData.chartData
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final data = entry.value;
                          final height = (data.earnings / 5000) *
                              160; // Scale to container

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

  // Property Earnings Widget
  Widget _buildPropertyEarnings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Earnings by Property',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 16),
        if (_earningsData.propertyBreakdown.isEmpty)
          // Empty State
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E5E7)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'No property earnings data available for this period.',
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF737373),
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          )
        else
          // Property List
          Column(
            children: _earningsData.propertyBreakdown
                .map((property) => _buildPropertyCard(property))
                .toList(),
          ),
      ],
    );
  }

  // Single Property Card Widget
  Widget _buildPropertyCard(PropertyBreakdown property) {
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
            // Property Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  property.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '\$${property.amount.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF22C55E),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: Color(0xFF737373),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Progress Bar
            Column(
              children: [
                // Progress Bar Container
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      // Progress Fill
                      Expanded(
                        flex: property.percentage.toInt(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      // Remaining Space
                      Expanded(
                        flex: 100 - property.percentage.toInt(),
                        child: const SizedBox(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Percentage Label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${property.percentage}% of total',
                    style: const TextStyle(
                      fontSize: 12,
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
    );
  }

  // Helper Methods
  void _showTimeFilterMenu(BuildContext context) {
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
              'Select Time Period',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 16),
            ...TimeFilter.values
                .map((filter) => ListTile(
                      title: Text(
                        filter.toString().split('.').last,
                        style: const TextStyle(fontFamily: 'Poppins'),
                      ),
                      trailing: _timeFilter == filter
                          ? const Icon(Icons.check, color: Color(0xFF22C55E))
                          : null,
                      onTap: () {
                        setState(() => _timeFilter = filter);
                        Navigator.pop(context);
                      },
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  void _handleExport(String format) {
    // Simulate export
    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _isLoading = false);
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exported as ${format.toUpperCase()}'),
          backgroundColor: const Color(0xFF22C55E),
        ),
      );
    });
  }
}
