// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Imports
// ⸻⸻⸻⸻⸻⸻⸻⸻

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_app/src/functions.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:health_app/theme/theme_service.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Reusable widget skeleton
// ⸻⸻⸻⸻⸻⸻⸻⸻
@immutable
class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    Key? key,
    required this.hospital,
    required this.identifier,
    required this.specialization,
    required this.appointmentTime,
  }) : super(key: key);

  final String hospital, identifier, specialization;
  final DateTime appointmentTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // * Title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 32,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Appointment Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // * Content
            const SizedBox(height: 10),
            Column(
              children: [
                /// Hospital
                ListTile(
                  leading: const Icon(
                    Icons.local_hospital,
                    color: Colors.white,
                  ),
                  title: Text(
                    hospital,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: const Text(
                    'Hospital',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                /// Health Card
                ListTile(
                  leading: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    identifier,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: const Text(
                    'Appointee',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                /// Specialization
                ListTile(
                  leading: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                  ),
                  title: Text(
                    specialization,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: const Text(
                    'Specialist',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                /// Health Card
                ListTile(
                  leading: const Icon(
                    Icons.schedule,
                    color: Colors.white,
                  ),
                  title: Text(
                    formattedDateTime(appointmentTime),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: const Text(
                    'Date and Time',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            /// Submit button
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.black,
                  primary: Colors.white,
                  elevation: 3,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                icon: const Icon(Icons.contacts),
                label: const Text('Contact Details'),
                onPressed: () {
                  infoSnackbar(
                      'Dr. ABC',
                      '+91-000-000-1234\nexample@domain.com\n\nThis feature will show contact details from a lookup table.',
                      true);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Appointment Card List
// ⸻⸻⸻⸻⸻⸻⸻⸻
class AppointmentList extends StatefulWidget {
  const AppointmentList({Key? key}) : super(key: key);

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  Query<Map<String, dynamic>> appointments = FirebaseFirestore.instance
      .collection('appointments')
      .orderBy('dateTime', descending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: appointments.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Swiper(
                  itemCount: snapshot.data!.docs.length,
                  control: SwiperControl(
                    color: ThemeServie().isSavedDarkMode()
                        ? Colors.white
                        : Colors.blue,
                  ),
                  itemBuilder: (_, index) {
                    return Center(
                      child: SingleChildScrollView(
                        child: AppointmentCard(
                          hospital:
                              snapshot.data!.docs[index]['hospital'].toString(),
                          identifier: snapshot.data!.docs[index]['appointee']
                              .toString(),
                          specialization: snapshot
                              .data!.docs[index]['specialization']
                              .toString(),
                          appointmentTime: DateTime.parse(snapshot
                              .data!.docs[index]['dateTime']
                              .toDate()
                              .toString()),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
