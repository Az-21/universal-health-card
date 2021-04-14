// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:get/get.dart';
import 'package:health_app/src/appointment/appointment_list.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// Other pages
import 'package:health_app/src/appointment/new_appointment.dart';
import 'package:health_app/src/appointment/locate_hospital.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Navigation UI
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class AppointmentWelcomePage extends StatefulWidget {
  const AppointmentWelcomePage({Key? key}) : super(key: key);

  @override
  _AppointmentWelcomePageState createState() => _AppointmentWelcomePageState();
}

class _AppointmentWelcomePageState extends State<AppointmentWelcomePage> {
  int _currentIndex = 1;
  List<Widget> healthCardPages = [
    Container(), // home conatiner -> this is never displayed -> goto home
    const AppointmentList(),
    const CreateAppointmentPage(),
    const HospitalLocator(),
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
            icon: const Icon(Icons.article_rounded),
            title: const Text("Appointments"),
            selectedColor: Colors.blue,
          ),

          /// Create Health Card
          SalomonBottomBarItem(
            icon: const Icon(Icons.post_add_outlined),
            title: const Text("New Appointment"),
            selectedColor: Colors.green,
          ),

          /// Add Health Card
          SalomonBottomBarItem(
            icon: const Icon(Icons.local_pharmacy),
            title: const Text("Nearest Hospital"),
            selectedColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
