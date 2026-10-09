import 'package:flutter/material.dart';

/// Task 9: Navigation Controls (BottomNavigationBar & TabBar).
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  static const _titles = ['Home', 'Messages', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final showTabs = _currentIndex == 1;

    // DefaultTabController wraps the whole Scaffold so the TabBar in the
    // AppBar and the TabBarView in the body share one controller.
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Task 9: ${_titles[_currentIndex]}'),
          // Exercise 9.2: top TabBar inside the AppBar (Messages view only).
          bottom: showTabs
              ? const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.chat), text: 'Chats'),
                    Tab(icon: Icon(Icons.call), text: 'Calls'),
                    Tab(icon: Icon(Icons.update), text: 'Status'),
                  ],
                )
              : null,
        ),
        body: switch (_currentIndex) {
          0 => const _PlaceholderView(icon: Icons.home, text: 'Welcome home!'),
          1 => const TabBarView(
            children: [
              _PlaceholderView(icon: Icons.chat, text: 'No new chats'),
              _PlaceholderView(icon: Icons.call, text: 'No recent calls'),
              _PlaceholderView(icon: Icons.update, text: 'No status updates'),
            ],
          ),
          _ => const _PlaceholderView(icon: Icons.person, text: 'Your profile'),
        },
        // Exercise 9.1: 3-tab BottomNavigationBar switching views.
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderView extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PlaceholderView({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 72, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text(text, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
