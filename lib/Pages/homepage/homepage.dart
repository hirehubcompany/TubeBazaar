import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tubebazaar/Pages/Add%20Jobs/homepage.dart';
import 'package:tubebazaar/Pages/Contracts/homepage.dart';

import 'home.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ContractPage(),//FinalHomepage(),
    ContractsScreen(),
    AddJobs(),
    OffersScreen(),
    FinalHomepage(), //ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black, // Set background color to black
        selectedItemColor: Colors.white, // Selected item color
        unselectedItemColor: Colors.grey, // Unselected item color
        type: BottomNavigationBarType.fixed, // Ensures items stay visible
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Contracts'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Offers'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Placeholder pages


class ContractsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Contracts Page'));
  }
}

class OffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
            },
            child: Text('Sign Out')
        ));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Page'));
  }
}
