// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

// Flutter Components Imports
import 'healthCard/health_cards_ui.dart';
import 'package:health_app/src/functions.dart';
import 'package:health_app/src/notes/notes_ui.dart';
import 'package:health_app/src/appointment/appointment_ui.dart';
import 'package:health_app/src/prescription/prescription_ui.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Stateful welcome message
// ⸻⸻⸻⸻⸻⸻⸻⸻
class WelcomeCard extends StatefulWidget {
  WelcomeCard({Key key}) : super(key: key);

  @override
  _WelcomeCardState createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard> {
  @override
  Widget build(BuildContext context) {
    return GFCard(
      color: Colors.green,
      title: GFListTile(
        title: GFTypography(
          text: 'Welcome User',
          showDivider: false,
          textColor: Colors.white,
          type: GFTypographyType.typo3,
          icon: Icon(
            Icons.person_pin_rounded,
            color: Colors.white,
            size: 32,
          ),
          dividerColor: Colors.white,
          dividerWidth: 100,
        ),
        subtitle: GFTypography(
          text: '${formattedDate()}',
          textColor: Colors.white,
          type: GFTypographyType.typo5,
          showDivider: false,
        ),
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Statess dashboard
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }

  ListView _buildListView() {
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    //  * ListTile Data
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    List<String> titles = [
      'Health Cards',
      'Appointment',
      'Prescription',
      'Doctor\'s Notes',
    ];
    List<String> subtitles = [
      'Add or view health cards',
      'Book and verify your doctor',
      'View your prescription',
      'Review your medical data',
    ];
    List<IconData> leadingIcons = [
      Icons.credit_card,
      Icons.qr_code_scanner_sharp,
      Icons.local_hospital_outlined,
      Icons.library_books_outlined,
    ];

    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    //  * Listview generator + divider (.separated)
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    return ListView.separated(
      shrinkWrap: true,
      itemCount: titles.length,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text('${titles[index]}'),
          leading: Icon(leadingIcons[index]),
          subtitle: Text('${subtitles[index]}'),
          trailing: Icon(Icons.arrow_forward_ios_sharp),
          onTap: () {
            switch (index) {
              case 0:
                Get.to(() =>
                    HealthCardWelcomePage()); // Imported ./health_cards.dart
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
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 2,
          height: 40,
          indent: 12,
          endIndent: 12,
        );
      },
    );
  }
}
