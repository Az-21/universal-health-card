// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:get/get.dart';

// Flutter Components Imports
import 'healthCard/health_cards.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Statess dashboard
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Padding(
      padding: EdgeInsets.all(16),
      child: _buildListView(),
    ));
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
                Get.to(() => HealthCardPage()); // Imported ./health_cards.dart
                break;
              case 1:
                //Get.to(() => __Module());
                break;
              case 2:
                //Get.to(() => __Module());
                break;
              case 3:
                //Get.to(() => __Module());
                break;
              default:
                print('Error in routing. Uncaught index.');
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
