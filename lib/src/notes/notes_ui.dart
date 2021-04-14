// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:get/get.dart';
import 'package:health_app/src/notes/add_notes.dart';
import 'package:health_app/src/notes/notes_list.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// Other pages
import 'package:health_app/src/appointment/locate_hospital.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Navigation UI
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class NotesWelcomePage extends StatefulWidget {
  const NotesWelcomePage({Key? key}) : super(key: key);

  @override
  _NotesWelcomePageState createState() => _NotesWelcomePageState();
}

class _NotesWelcomePageState extends State<NotesWelcomePage> {
  int _currentIndex = 1;
  List<Widget> healthCardPages = [
    Container(), // home conatiner -> this is never displayed -> goto home
    const NotesList(),
    const CreateNotesPage(),
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

          /// Health Details
          SalomonBottomBarItem(
            icon: const Icon(Icons.notes_sharp),
            title: const Text("Health Notes"),
            selectedColor: Colors.blue,
          ),

          /// Create Health Card
          SalomonBottomBarItem(
            icon: const Icon(Icons.note_add_sharp),
            title: const Text("New Health Note"),
            selectedColor: Colors.green,
          ),

          /// Nearest Hospital
          SalomonBottomBarItem(
            icon: const Icon(Icons.local_hospital_outlined),
            title: const Text("Nearest Hospital"),
            selectedColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
