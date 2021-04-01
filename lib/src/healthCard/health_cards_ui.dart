// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';
import 'package:health_app/src/healthCard/sync_health_card.dart';

// Pub Dev Imports
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:get/get.dart';

// Flutter Components Imports for Navigation
import 'new_health_card.dart';
import 'health_card_list.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Navigation UI
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class HealthCardWelcomePage extends StatefulWidget {
  HealthCardWelcomePage({Key key}) : super(key: key);

  @override
  _HealthCardWelcomePageState createState() => _HealthCardWelcomePageState();
}

class _HealthCardWelcomePageState extends State<HealthCardWelcomePage> {
  int _currentIndex = 1;
  List<Widget> healthCardPages = [
    Container(), // home conatiner -> this is never displayed -> goto home
    HealthCardPage(),
    NewHealthCard(),
    SyncHealthCard(),
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
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Health Cards
          SalomonBottomBarItem(
            icon: Icon(Icons.dashboard),
            title: Text("Health Cards"),
            selectedColor: Colors.blue,
          ),

          /// Create Health Card
          SalomonBottomBarItem(
            icon: Icon(Icons.dashboard_customize),
            title: Text("Create Health Card"),
            selectedColor: Colors.green,
          ),

          /// Add Health Card
          SalomonBottomBarItem(
            icon: Icon(Icons.sync),
            title: Text("Sync Health Card"),
            selectedColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
