// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Imports
// ⸻⸻⸻⸻⸻⸻⸻⸻

import 'package:flutter/material.dart';
import 'package:health_app/src/functions.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Reusable widget skeleton
// ⸻⸻⸻⸻⸻⸻⸻⸻
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
      elevation: 10,
      margin: EdgeInsets.only(top: 20),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 32,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Appointment Details',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 10),

            // * Subtitle
            Container(
                child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('$identifier'),
                  subtitle: Text('Booked user'),
                ),
                ListTile(
                  leading: Icon(Icons.local_hospital),
                  title: Text('$hospital'),
                  subtitle: Text('Name of hospital'),
                ),
                ListTile(
                  leading: Icon(Icons.medical_services),
                  title: Text('$specialization'),
                  subtitle: Text('Specialist requested'),
                ),
                ListTile(
                  leading: Icon(Icons.access_time),
                  title: Text(formattedDateTime(appointmentTime)),
                  subtitle: Text('Time slot'),
                ),
              ],
            )),
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
  AppointmentList({Key? key}) : super(key: key);

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        // rename to ListView.builder if separator isn't required
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemCount: 4,
        shrinkWrap: true,
        // Widget children
        itemBuilder: (_, index) {
          return AppointmentCard(
            hospital: 'ABC Hospital',
            identifier: 'Firstname | 0001',
            specialization: 'General Practitioner',
            appointmentTime: DateTime.now(),
          );
        },
      ),
    );
  }
}
