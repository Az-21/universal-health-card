// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:get/get.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:health_app/theme/theme_service.dart';

// Flutter Components Imports
import 'healthCard/health_cards_ui.dart';
import 'package:health_app/src/notes/notes_ui.dart';
import 'package:health_app/src/appointment/appointment_ui.dart';
import 'package:health_app/src/prescription/prescription_ui.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Stateless Homescreen
// ⸻⸻⸻⸻⸻⸻⸻⸻
class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  static final List<String> _title = [
    'Health Card',
    'Appointment',
    'Prescription',
    'Doctor\'s Notes',
  ];
  static final List<String> _subtitle = [
    'Add or view health cards',
    'Book and verify your doctor',
    'View your prescription',
    'View your medical data',
  ];

  static final List<List<Color>> _gradientColors = [
    [Colors.green, Colors.greenAccent],
    [Colors.green, Colors.yellow],
    [Colors.purple, Colors.indigo],
    [Colors.red, Colors.orange],
  ];

  static final List<Icon> _cardIcons = [
    Icon(Icons.dashboard_rounded, color: Colors.white),
    Icon(Icons.qr_code_scanner_rounded, color: Colors.white),
    Icon(Icons.healing_outlined, color: Colors.white),
    Icon(Icons.note_add, color: Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          clipBehavior: Clip.none,
          height: MediaQuery.of(context).size.height * 0.9,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Swiper(
            itemCount: 4,
            control: new SwiperControl(
                color: ThemeServie().isSavedDarkMode()
                    ? Colors.white
                    : Colors.black),
            itemWidth: MediaQuery.of(context).size.width * 0.75,
            itemHeight: MediaQuery.of(context).size.height * 0.7,
            layout: SwiperLayout.STACK,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  /// * Background Card Gradient
                  Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: new LinearGradient(
                        colors: _gradientColors[index],
                        begin: Alignment(1, 1),
                        end: Alignment(-1, -1),
                      ),
                    ),
                  ),

                  /// * Card body: icon + title + subtitle
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacer(),
                        Center(
                          child: IconButton(
                            icon: _cardIcons[index],
                            onPressed: () => _pageLauncher(index),
                            iconSize: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                        Spacer(),
                        Text(
                          _title[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _subtitle[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -MediaQuery.of(context).size.height * 0.05,
                    right: MediaQuery.of(context).size.height * 0.05,
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                      // TODO: Add images here
                      child: Placeholder(),
                    ),
                  ),
                ],
              );
            },
            onTap: (index) => _pageLauncher(index),
          ),
        ),
      ),
    );
  }
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Dashboard page launcher
// ⸻⸻⸻⸻⸻⸻⸻⸻
void _pageLauncher(int index) {
  switch (index) {
    case 0:
      Get.to(() => HealthCardWelcomePage()); // Imported ./health_cards.dart
      break;
    case 1:
      Get.to(() => AppointmentWelcomePage());
      break;
    case 2:
      Get.to(() => PrescriptionWelcomePage());
      break;
    case 3:
      Get.to(() => NotesWelcomePage());
      break;
  }
}
