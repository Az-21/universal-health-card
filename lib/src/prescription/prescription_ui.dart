// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_app/src/prescription/locate_pharma.dart';
import 'package:health_app/src/prescription/prescription_list.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'add_prescription.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Navigation UI
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class PrescriptionWelcomePage extends StatefulWidget {
  const PrescriptionWelcomePage({Key? key}) : super(key: key);

  @override
  _PrescriptionWelcomePageState createState() =>
      _PrescriptionWelcomePageState();
}

class _PrescriptionWelcomePageState extends State<PrescriptionWelcomePage> {
  int _currentIndex = 1;
  List<Widget> healthCardPages = [
    Container(), // home conatiner -> this is never displayed -> goto home
    const PrescriptionList(),
    const PrescriptionCardAdder(),
    const PharmaLocator(),
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

          /// Prescription
          SalomonBottomBarItem(
            icon: const Icon(Icons.article_rounded),
            title: const Text("Prescription"),
            selectedColor: Colors.blue,
          ),

          /// Prescription adder
          SalomonBottomBarItem(
            icon: const Icon(Icons.post_add_outlined),
            title: const Text("New Prescription"),
            selectedColor: Colors.green,
          ),

          /// Pharma locator
          SalomonBottomBarItem(
            icon: const Icon(Icons.local_pharmacy),
            title: const Text("Nearest Pharmacy"),
            selectedColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
