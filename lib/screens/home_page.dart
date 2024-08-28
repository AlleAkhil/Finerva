import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../app_navigator.dart'; // Import the AppNavigator

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Use AppNavigator for navigation
    switch (index) {
      case 0:
        AppNavigator.navigateTo('/home');
        break;
      case 1:
        AppNavigator.navigateTo('/search');
        break;
      case 2:
        AppNavigator.navigateTo('/chart');
        break;
      case 3:
        AppNavigator.navigateTo('/cards');
        break;
      case 4:
        AppNavigator.navigateTo('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Home'),
            CircleAvatar( // Replaced the credit card icon with CircleAvatar
              backgroundImage: AssetImage('assets/images/profile_picture.png'),
            ),
          ],
        ),
      ),
      drawer: _buildDrawer(context), // Build the drawer menu
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Balance Section resembling a Credit Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity, // Make container take the full width of the screen
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.blue[700]!, Colors.blue[300]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account Balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '\$5,943',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(color: Color(0xFFDCE1E5), thickness: 1),
            // Savings Progress Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Savings Progress',
                    style: TextStyle(color: Color(0xFF111517), fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$2,500',
                    style: TextStyle(color: Color(0xFF111517), fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Text(
                        'Last 30 Days',
                        style: TextStyle(color: Color(0xFF647987), fontSize: 14),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '+8%',
                        style: TextStyle(color: Color(0xFF078838), fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Real Chart for Savings Progress
                  SizedBox(
                    height: 180,
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
                              FlSpot(1, 1.5),
                              FlSpot(2, 1.4),
                              FlSpot(3, 3.4),
                              FlSpot(4, 2),
                              FlSpot(5, 2.2),
                              FlSpot(6, 1.8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('1D', style: TextStyle(color: Color(0xFF647987), fontSize: 13, fontWeight: FontWeight.bold)),
                      Text('1W', style: TextStyle(color: Color(0xFF647987), fontSize: 13, fontWeight: FontWeight.bold)),
                      Text('1M', style: TextStyle(color: Color(0xFF647987), fontSize: 13, fontWeight: FontWeight.bold)),
                      Text('3M', style: TextStyle(color: Color(0xFF647987), fontSize: 13, fontWeight: FontWeight.bold)),
                      Text('1Y', style: TextStyle(color: Color(0xFF647987), fontSize: 13, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFFDCE1E5), thickness: 1),
            // Earnings Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildFinancialCard(
                    title: 'Earnings',
                    subtitle: 'Your income for this month',
                    buttonText: 'View details',
                    onPressed: () {},
                    chartWidget: BarChart(
                      BarChartData(
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(toY: 3, color: Colors.teal),
                          ]),
                          BarChartGroupData(x: 1, barRods: [
                            BarChartRodData(toY: 5, color: Colors.orange),
                          ]),
                          BarChartGroupData(x: 2, barRods: [
                            BarChartRodData(toY: 7, color: Colors.green),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Outgoings Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildFinancialCard(
                    title: 'Outgoings',
                    subtitle: 'Your expenses for this month',
                    buttonText: 'View details',
                    onPressed: () {},
                    chartWidget: BarChart(
                      BarChartData(
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(toY: 2, color: Colors.teal),
                          ]),
                          BarChartGroupData(x: 1, barRods: [
                            BarChartRodData(toY: 6, color: Colors.orange),
                          ]),
                          BarChartGroupData(x: 2, barRods: [
                            BarChartRodData(toY: 8, color: Colors.green),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: Color(0xFFDCE1E5), thickness: 1),
            // Financial Targets Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Financial Targets',
                    style: TextStyle(color: Color(0xFF111517), fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildTargetRow('Savings', '\$10,000'),
                  _buildTargetRow('Investments', '\$5,000'),
                  _buildTargetRow('Expenses', '\$3,000'),
                  _buildTargetRow('Income', '\$7,000'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF111517)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Color(0xFF647987)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart, color: Color(0xFF647987)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card, color: Color(0xFF647987)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFF647987)),
            label: '',
          ),
        ],
        selectedItemColor: const Color(0xFF1d8cd7),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Chris Johnson"),
            accountEmail: Text("chris.johnson@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_picture.png'),
            ),
            decoration: BoxDecoration(
              color: Colors.blue[800],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              AppNavigator.navigateTo('/home');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle navigation to Settings
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialCard({
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
    required Widget chartWidget,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 180, child: chartWidget),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Color(0xFF111517), fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subtitle,
                      style: const TextStyle(color: Color(0xFF647987), fontSize: 14),
                    ),
                    ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1d8cd7),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(buttonText),
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

  Widget _buildTargetRow(String title, String amount) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: Color(0xFF647987), fontSize: 16)),
            Text(amount, style: const TextStyle(color: Color(0xFF111517), fontSize: 16)),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(color: Color(0xFFDCE1E5), thickness: 1),
      ],
    );
  }
}
