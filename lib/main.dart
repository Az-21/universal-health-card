// Dart native imports
import 'package:flutter/material.dart';

// Pub dev imports
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// src
import './src/healthCard.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  Run app
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
void main() {
  runApp(MyApp());
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  Home screen preferences
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Health App Mini-Project',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.system,
        home: HomeScreen());
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  Home screen
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health App'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help_center_outlined),
            tooltip: 'Reserved', // udecided function
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'INFO: reserved for settings or some other function')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Mini-project',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('TODO: Add information page')));
            },
          ),
          const SizedBox(width: 8), // padding
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(40, 40, 0, 0),
                child: Text(
                  "Health Cards",
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.greenAccent,
                  ),
                )),
            HealthCards(),
          ]),
      bottomNavigationBar: BNB(),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  Bottom Navigation Bar (BNB) // FIXME: transfer to separate .dart file
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class BNB extends StatefulWidget {
  BNB({Key key}) : super(key: key);

  @override
  _BNBState createState() => _BNBState();
}

class _BNBState extends State<BNB> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      items: [
        // Home
        SalomonBottomBarItem(
          icon: Icon(Icons.home),
          title: Text("Home"),
          selectedColor: Colors.green,
        ),

        // Patient Data - Medical History
        SalomonBottomBarItem(
          icon: Icon(Icons.library_books),
          title: Text("Medical History"),
          selectedColor: Colors.blue,
        ),

        // Medication / Prescription
        SalomonBottomBarItem(
          icon: Icon(Icons.medical_services_outlined),
          title: Text("℞ Prescription"),
          selectedColor: Colors.red,
        ),

        // Search
        SalomonBottomBarItem(
          icon: Icon(Icons.search_rounded),
          title: Text("Search"),
          selectedColor: Colors.yellow,
        ),
      ],
    );
  }
}
