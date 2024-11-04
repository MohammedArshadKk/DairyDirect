import 'package:dairy_direct/view/screens/salesman/in_transit_screen.dart';
import 'package:dairy_direct/view/screens/salesman/salesman_home.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    SalesmanHome(),
    IntransitScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: 'Product In-Transit',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.blue[600],
        onTap: _onItemTapped,
      ),
    );
  }
}
