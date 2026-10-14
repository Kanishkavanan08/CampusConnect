import 'package:flutter/material.dart';
import '../tasks/task_screen.dart'; // Import our new Task Screen

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Track which tab is currently selected (0 = Tasks, 1 = Events, etc.)
  int _currentIndex = 0;

  // A list of widgets to show based on the selected tab
  final List<Widget> _screens = [
    const TaskScreen(), // <--- Index 0 now points to our working Provider screen!
    const Center(child: Text('Events Screen', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Announcements Screen', style: TextStyle(fontSize: 20))),
    const Center(child: Text('Profile Screen', style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CampusConnect'),
      ),
      // The body changes based on _currentIndex
      body: _screens[_currentIndex],

      // The bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed, // Keeps all icons visible
        onTap: (index) {
          // setState tells Flutter to rebuild the screen with the new index
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: 'News'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}