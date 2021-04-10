// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Imports
// ⸻⸻⸻⸻⸻⸻⸻⸻
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
      timestamp,
      submitterName,
      submitterOrg,
      temp,
      height,
      weight,
      bpS,
      bpD,
      message;
  final bool submitterVerified;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        margin: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                identifier,
                style: TextStyle(fontSize: 16),
              ),
              Divider(),
              // * Date
              Text(
                timestamp,
                style: TextStyle(fontSize: 12),
              ),

              // * Name of submitter + icon
              Row(
                children: [
                  Text(
                    submitterName,
                    style: TextStyle(fontSize: 14),
                  ),
                  Spacer(),
                  submitterVerified
                      ? Icon(
                          Icons.verified,
                          size: 40,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.supervised_user_circle,
                          size: 40,
                          color: Colors.blue,
                        )
                ],
              ),
              // * Orgnization of submitter
              Text(
                submitterOrg,
                style: TextStyle(fontSize: 12),
              ),

              Divider(height: 30),

              MarkdownBody(
                data:
                    '# Vitals\n---\n* Temperature: $temp °C\n* Height: $height cm\n* Weight: $weight kg\n* Blood pressure: $bpS / $bpD mmH\n\n $message',
              )
            ],
          ),
        ));
  }
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Appointment Card List
// ⸻⸻⸻⸻⸻⸻⸻⸻
class NotesList extends StatefulWidget {
  NotesList({Key? key}) : super(key: key);

  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        // rename to ListView.builder if separator isn't required
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemCount: 2,
        shrinkWrap: true,
        // Widget children
        itemBuilder: (_, index) {
          return NotesCard(
            identifier: 'Firstname | 0001',
            timestamp: 'Saturday | April 10, 2021',
            submitterName: 'Dr. XYZ',
            submitterOrg: 'ABC Hospital',
            submitterVerified: true,
            temp: '36.5',
            height: '180',
            weight: '80',
            bpS: '120',
            bpD: '80',
            message:
                '# Symptoms\n---\n* Body pain \n* Sore eyes \n\n# Notes\n---\n* Diagnosis <//> \n* <Medical reference for other doctors>\n# Instructions\n---\n* Eight hours of sleep\n* Regularly apply eyedrops',
          );
        },
      ),
    );
  }
}
