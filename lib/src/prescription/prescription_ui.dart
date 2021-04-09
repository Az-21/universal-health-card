// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:get/get.dart';

// Imports from other .dart files
import 'add_prescription.dart';
import 'package:health_app/src/prescription/locate_pharma.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Navigation UI
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class PrescriptionWelcomePage extends StatefulWidget {
  PrescriptionWelcomePage({Key? key}) : super(key: key);

  @override
  _PrescriptionWelcomePageState createState() =>
      _PrescriptionWelcomePageState();
}

class _PrescriptionWelcomePageState extends State<PrescriptionWelcomePage> {
  int _currentIndex = 1;
  List<Widget> healthCardPages = [
    Container(), // home conatiner -> this is never displayed -> goto home
    Container(
      padding: EdgeInsets.all(50),
      child: Text('Add prescription here // classified by health card'),
    ),
    PrescriptionCardAdder(),
    PharmaLocator(),
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

          /// Prescription
          SalomonBottomBarItem(
            icon: Icon(Icons.article_rounded),
            title: Text("Prescription"),
            selectedColor: Colors.blue,
          ),

          /// Prescription adder
          SalomonBottomBarItem(
            icon: Icon(Icons.post_add_outlined),
            title: Text("New Prescription"),
            selectedColor: Colors.green,
          ),

          /// Pharma locator
          SalomonBottomBarItem(
            icon: Icon(Icons.local_pharmacy),
            title: Text("Nearest Pharmacy"),
            selectedColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
