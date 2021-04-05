// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// Other pages
import 'package:health_app/src/appointment/locate_hospital.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Navigation UI
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class AppointmentWelcomePage extends StatefulWidget {
  AppointmentWelcomePage({Key key}) : super(key: key);

  @override
  _AppointmentWelcomePageState createState() => _AppointmentWelcomePageState();
}

class _AppointmentWelcomePageState extends State<AppointmentWelcomePage> {
  int _currentIndex = 1;
  List<Widget> healthCardPages = [
    Container(), // home conatiner -> this is never displayed -> goto home
    Container(
      padding: EdgeInsets.all(50),
      child: Text('Add appointments here // classified by category'),
    ),
    Container(
      padding: EdgeInsets.all(50),
      child: Text('Add appointment adder here // classified by category'),
    ),
    HospitalLocator(),
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
            icon: Icon(Icons.article_rounded),
            title: Text("Appointments"),
            selectedColor: Colors.blue,
          ),

          /// Create Health Card
          SalomonBottomBarItem(
            icon: Icon(Icons.post_add_outlined),
            title: Text("New Appointment"),
            selectedColor: Colors.green,
          ),

          /// Add Health Card
          SalomonBottomBarItem(
            icon: Icon(Icons.local_pharmacy),
            title: Text("Nearest Hospital"),
            selectedColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
