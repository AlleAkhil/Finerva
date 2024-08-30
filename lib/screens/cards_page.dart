import 'package:flutter/material.dart';
import '../app_navigator.dart'; // Import the AppNavigator

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  int _selectedIndex = 3; // Set the initial selected index for the cards tab

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
          AppNavigator.navigateTo('/chart');
          break;
        case 3:
          AppNavigator.navigateTo('/cards'); // We're already on the cards page, no need to navigate
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
        title: const Text('Cards'),
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
          children: [
            // Total Overview Card
            Card(
              color: Colors.grey[100], // Light grey background to match the white theme
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total overview',
                      style: TextStyle(
                        color: Colors.black, // Changed text color to black
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '\$ 222,358',
                      style: TextStyle(
                        color: Colors.black, // Changed text color to black
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '**** **** **** 0322',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Switch(
                        value: true,
                        onChanged: (bool value) {
                          // Handle switch action
                        },
                        activeColor: Colors.black, // Changed switch color to black
                        activeTrackColor: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tab Bar Section
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100], // Light grey background to match the white theme
                borderRadius: BorderRadius.circular(15),
              ),
              child: DefaultTabController(
                length: 4,
                child: TabBar(
                  labelColor: Colors.black, // Changed label color to black
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black, // Changed indicator color to black
                  tabs: const [
                    Tab(text: 'Overview'),
                    Tab(text: 'Budget'),
                    Tab(text: 'Financial'),
                    Tab(text: 'Recent'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Current Balance Section
            Expanded(
              child: Card(
                color: Colors.grey[100], // Light grey background to match the white theme
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current balance',
                        style: TextStyle(
                          color: Colors.black, // Changed text color to black
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Expense',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Income',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Placeholder for bar chart
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(9, (index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: (index % 2 == 0) ? 60.0 : 40.0,
                                  width: 10,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  ['Janua', 'Febr', 'Marc', 'April', 'May', 'June', 'July', 'Aug', 'Septe'][index],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Monthly Section
            Expanded(
              child: Card(
                color: Colors.grey[100], // Light grey background to match the white theme
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Monthly',
                        style: TextStyle(
                          color: Colors.black, // Changed text color to black
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Travel',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Food',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            'Housing',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Placeholder for bar chart
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(3, (index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: (index % 2 == 0) ? 60.0 : 40.0,
                                  width: 30,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  ['January', 'February', 'March'][index],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
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
