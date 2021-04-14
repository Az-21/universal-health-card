// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/src/healthCard/sync_health_card.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'health_card_list.dart';
import 'new_health_card.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Navigation UI
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class HealthCardWelcomePage extends StatefulWidget {
  const HealthCardWelcomePage({Key? key}) : super(key: key);

  @override
  _HealthCardWelcomePageState createState() => _HealthCardWelcomePageState();
}

class _HealthCardWelcomePageState extends State<HealthCardWelcomePage> {
  int _currentIndex = 1;
  List<Widget> healthCardPages = [
    Container(), // home conatiner -> this is never displayed -> goto home
    const HealthCardPage(),
    const NewHealthCard(),
    const SyncHealthCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appbar: not reqd, each page has its own
      body: healthCardPages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        selectedColorOpacity: 0.1,
        unselectedItemColor: Colors.grey[400],
        onTap: (index) {
          if (index == 0) {
            Get.back(); // goto home
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          /// Go to Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Health Cards
          SalomonBottomBarItem(
            icon: const Icon(Icons.dashboard),
            title: const Text("Health Cards"),
            selectedColor: Colors.blue,
          ),

          /// Create Health Card
          SalomonBottomBarItem(
            icon: const Icon(Icons.dashboard_customize),
            title: const Text("Create Health Card"),
            selectedColor: Colors.green,
          ),

          /// Add Health Card
          SalomonBottomBarItem(
            icon: const Icon(Icons.sync),
            title: const Text("Sync Health Card"),
            selectedColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
