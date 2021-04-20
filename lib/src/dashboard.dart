// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:health_app/src/appointment/appointment_ui.dart';
import 'package:health_app/src/notes/notes_ui.dart';
import 'package:health_app/src/prescription/prescription_ui.dart';
import 'package:health_app/theme/theme_service.dart';

import 'healthCard/health_cards_ui.dart';

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

  static final List<FaIcon> _cardIcons = [
    const FaIcon(FontAwesomeIcons.solidIdBadge,
        color: CupertinoColors.activeGreen),
    const FaIcon(FontAwesomeIcons.calendarPlus, color: Colors.blue),
    const FaIcon(FontAwesomeIcons.prescriptionBottleAlt, color: Colors.red),
    const FaIcon(FontAwesomeIcons.notesMedical, color: Colors.blueGrey),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Swiper(
            itemCount: 4,
            control: SwiperControl(
                color: ThemeServie().isSavedDarkMode()
                    ? Colors.white
                    : Colors.black),
            itemWidth: MediaQuery.of(context).size.width * 0.75,
            itemHeight: MediaQuery.of(context).size.height * 0.6,
            layout: SwiperLayout.STACK,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  /// * Background Card Gradient
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // * Title
                            Text(
                              _title[index],
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            // * Subtitle
                            const SizedBox(height: 5),
                            Text(
                              _subtitle[index],
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: -MediaQuery.of(context).size.height * 0.049,
                    right: MediaQuery.of(context).size.height * 0.08,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                      // TODO: Add images here
                      child: IconButton(
                        icon: _cardIcons[index],
                        onPressed: () => _pageLauncher(index),
                        iconSize: MediaQuery.of(context).size.height * 0.25,
                      ),
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
      Get.to(
          () => const HealthCardWelcomePage()); // Imported ./health_cards.dart
      break;
    case 1:
      Get.to(() => const AppointmentWelcomePage());
      break;
    case 2:
      Get.to(() => const PrescriptionWelcomePage());
      break;
    case 3:
      Get.to(() => const NotesWelcomePage());
      break;
  }
}
