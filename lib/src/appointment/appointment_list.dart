// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Imports
// ⸻⸻⸻⸻⸻⸻⸻⸻

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
      elevation: 2,
      margin: const EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // * Title

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Icon(Icons.arrow_forward_ios_sharp, size: 32),
                const SizedBox(width: 10),
                const Text('Appointment Details',
                    style: TextStyle(fontSize: 20)),
              ],
            ),

            const SizedBox(height: 10),

            // * Subtitle
            Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(identifier),
                  subtitle: const Text('Booked user'),
                ),
                ListTile(
                  leading: const Icon(Icons.local_hospital),
                  title: Text(hospital),
                  subtitle: const Text('Name of hospital'),
                ),
                ListTile(
                  leading: const Icon(Icons.medical_services),
                  title: Text(specialization),
                  subtitle: const Text('Specialist requested'),
                ),
                ListTile(
                  leading: const Icon(Icons.access_time),
                  title: Text(formattedDateTime(appointmentTime)),
                  subtitle: const Text('Time slot'),
                ),
              ],
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Swiper(
            itemCount: 3,
            control: SwiperControl(
                color: ThemeServie().isSavedDarkMode()
                    ? Colors.white
                    : Colors.blue),
            itemBuilder: (_, index) {
              return SingleChildScrollView(
                child: AppointmentCard(
                  hospital: 'ABC Hospital',
                  identifier: 'Firstname | 00${(index + 1) * 10}',
                  specialization: 'General Practitioner',
                  appointmentTime: DateTime.now(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
