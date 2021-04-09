// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:get/get.dart';

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
  WelcomeCard({Key? key}) : super(key: key);

  @override
  _WelcomeCardState createState() => _WelcomeCardState();
}

class _WelcomeCardState extends State<WelcomeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // * Title
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.api,
                    color: Colors.white,
                    size: 32,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Welcome User',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 10),

            // * Subtitle
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                formattedDate(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Statess dashboard
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

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
