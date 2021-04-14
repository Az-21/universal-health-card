// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';
import 'package:health_app/src/functions.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Stateless URL Launcher
// ⸻⸻⸻⸻⸻⸻⸻⸻
class PharmaLocator extends StatelessWidget {
  const PharmaLocator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 32),

          // * Launch map
          const ImageFunctionCard(
            title: 'Locate Pharmacy',
            subtitle:
                '\nLocate the nearby pharmacies using your default map application.\n\nDefaults to Google Maps.',
            icon: Icons.map,
            imagePath: 'assets/image/map.jpg',
            url: 'pharmacy near me',
            isMap: true,
          ),

          const SizedBox(height: 32),

          // * Launch search
          const ImageFunctionCard(
            title: 'Search Pharmacy',
            subtitle: '\nSearch pharmacies near you using Google',
            icon: Icons.search,
            imagePath: 'assets/image/search.jpg',
            url: 'https://www.google.com/search?q=pharmacy+near+me',
            isMap: false,
          ),
        ],
      ),
    );
  }
}
