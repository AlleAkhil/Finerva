import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../app_navigator.dart'; // Import the AppNavigator

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  int _selectedIndex = 2; // Set the initial selected index for the stats tab

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      // Use AppNavigator for navigation
      switch (index) {
        case 0:
          AppNavigator.navigateTo('/home');
          break;
        case 1:
          AppNavigator.navigateTo('/plan');
          break;
        case 2:
          AppNavigator.navigateTo('/chart'); // We're already on the stats page, no need to navigate
          break;
        case 3:
          AppNavigator.navigateTo('/cards');
          break;
        case 4:
          AppNavigator.navigateTo('/profile');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      appBar: AppBar(
        title: const Text('Statistics'),
        centerTitle: true,
        backgroundColor: Colors.white, // White background for AppBar
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AppNavigator.navigateTo('/home'); // Navigate to the home page when back icon is pressed
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stats Overview',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Line Chart Section
            Expanded(
              child: Card(
                color: Colors.grey[100], // Light grey background to match the white theme
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 4,
                          spots: const [
                            FlSpot(0, 1),
                            FlSpot(1, 3),
                            FlSpot(2, 2),
                            FlSpot(3, 5),
                            FlSpot(4, 3),
                            FlSpot(5, 4),
                            FlSpot(6, 6),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bar Chart Section
            Expanded(
              child: Card(
                color: Colors.grey[100], // Light grey background to match the white theme
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BarChart(
                    BarChartData(
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(show: false),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(toY: 3, color: Colors.teal),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(toY: 5, color: Colors.orange),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(toY: 7, color: Colors.green),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(toY: 4, color: Colors.red),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(toY: 6, color: Colors.purple),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppNavigator.buildBottomNavigationBar(_selectedIndex, _onItemTapped),
    );
  }
}
