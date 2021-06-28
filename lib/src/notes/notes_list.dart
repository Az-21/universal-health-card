// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Imports
// ⸻⸻⸻⸻⸻⸻⸻⸻
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:health_app/src/functions.dart';
import 'package:health_app/theme/theme_service.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Reusable widget skeleton
// ⸻⸻⸻⸻⸻⸻⸻⸻
class NotesCard extends StatelessWidget {
  const NotesCard({
    Key? key,
    required this.identifier,
    required this.timestamp,
    required this.submitterName,
    required this.submitterOrg,
    required this.submitterVerified,
    required this.temp,
    required this.height,
    required this.weight,
    required this.bpS,
    required this.bpD,
    required this.message,
  }) : super(key: key);

  final String identifier,
      submitterName,
      submitterOrg,
      temp,
      height,
      weight,
      bpS,
      bpD,
      message;
  final bool submitterVerified;
  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // * Identifier
                      Text(
                        identifier,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Divider(),
                      // * Date
                      Text(
                        formattedDateTime(timestamp),
                        style: const TextStyle(fontSize: 12),
                      ),

                      // * Name of submitter + icon
                      Row(
                        children: [
                          Text(
                            submitterName,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const Spacer(),
                          if (submitterVerified)
                            const Icon(
                              Icons.verified,
                              size: 40,
                              color: Colors.green,
                            )
                          else
                            const Icon(
                              Icons.supervised_user_circle,
                              size: 40,
                              color: Colors.blue,
                            )
                        ],
                      ),
                      // * Orgnization of submitter
                      Text(
                        submitterOrg,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      MarkdownBody(
                        data:
                            '## Vitals\n---\n* Temperature: $temp °F\n* Height: $height cm\n* Weight: $weight kg\n* Blood pressure: $bpS / $bpD mmH',
                      ),
                    ],
                  ),
                ),
              ),

              // * Actual Notes
              const SizedBox(height: 20),
              MarkdownBody(
                data: message,
              ),

              // * Contact Doctor
              /// Submit button
              Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  label: const Text('Contact Doctor'),
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
        ));
  }
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Appointment Card List
// ⸻⸻⸻⸻⸻⸻⸻⸻
class NotesList extends StatefulWidget {
  const NotesList({Key? key}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  // * Firestore hook
  Query<Map<String, dynamic>> notes = FirebaseFirestore.instance
      .collection('notes')
      .orderBy('dateTime', descending: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: notes.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.9,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Swiper(
                  itemCount: snapshot.data!.docs.length,
                  control: SwiperControl(
                    color: ThemeServie().isSavedDarkMode()
                        ? Colors.white
                        : Colors.blue,
                  ),
                  itemBuilder: (_, index) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: NotesCard(
                        identifier:
                            snapshot.data!.docs[index]['forUser'].toString(),
                        timestamp: DateTime.parse(snapshot
                            .data!.docs[index]['dateTime']
                            .toDate()
                            .toString()),
                        submitterName:
                            snapshot.data!.docs[index]['byUser'].toString(),
                        submitterOrg: snapshot.data!.docs[index]['orgnization']
                            .toString(),
                        submitterVerified:
                            // ignore: avoid_bool_literals_in_conditional_expressions
                            snapshot.data!.docs[index]['isDoctor'].toString() ==
                                    'true'
                                ? true
                                : false,
                        temp: snapshot.data!.docs[index]['temperature']
                            .toString(),
                        height: snapshot.data!.docs[index]['height'].toString(),
                        weight: snapshot.data!.docs[index]['weight'].toString(),
                        bpS: snapshot.data!.docs[index]['bpS'].toString(),
                        bpD: snapshot.data!.docs[index]['bpD'].toString(),
                        message: snapshot.data!.docs[index]['note'].toString(),
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
