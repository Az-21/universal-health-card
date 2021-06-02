import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_app/src/functions.dart';

class CreateAppointmentPage extends StatefulWidget {
  const CreateAppointmentPage({Key? key}) : super(key: key);

  @override
  _CreateAppointmentPageState createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  TextEditingController hospital = TextEditingController();
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('appointments');

  List<String> cardList = [
    'Abhijit | xxxx xxxx 0002',
    'Abhishek | xxxx xxxx 0003',
    'Amogh | xxxx xxxx 0009',
    'Dhruv | xxxx xxxx 0015',
  ];
  int _selectedCard = 0;

  List<String> fieldSpl = [
    'General Practitioner',
    'ENT Specialist',
    'Pediatrist',
    'Cardiologist',
    'Opthamologist',
    'Neurologist',
  ];
  int _selectedSpecialist = 0;

  DateTime now = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: [
          /// * TextField: Name of Hospital
          const SizedBox(height: 20),
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
                  // * Title
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(Icons.local_hospital, size: 32),
                        const SizedBox(width: 10),
                        const Text('Hospital', style: TextStyle(fontSize: 20))
                      ],
                    ),
                  ),

                  // * Subtitle
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('Appointment will be scheduled at'),
                  ),

                  // * Content
                  const SizedBox(height: 10),
                  TextField(
                    controller: hospital,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name of Hospital',
                      hintText: 'MS Ramaiah Hospital',
                    ),
                    onSubmitted: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),

          /// * Cupertino Picker: Pick Card
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
                  // * Title
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(Icons.credit_card, size: 32),
                        const SizedBox(width: 10),
                        const Text('Health Card',
                            style: TextStyle(fontSize: 20))
                      ],
                    ),
                  ),

                  // * Subtitle
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('Appointment will be made for'),
                  ),

                  // * Content
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 90,
                    child: CupertinoPicker(
                      squeeze: 0.9,
                      itemExtent: 36,
                      looping: true,
                      diameterRatio: 2,
                      onSelectedItemChanged: (index) {
                        _selectedCard = index;
                        setState(() {});
                      },
                      children: [
                        for (String cardNumber in cardList)
                          Center(child: Text(cardNumber)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// * Cupertino Picker: Specialist
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
                  // * Title
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(Icons.auto_awesome, size: 32),
                        const SizedBox(width: 10),
                        const Text('Specialization',
                            style: TextStyle(fontSize: 20))
                      ],
                    ),
                  ),

                  // * Subtitle
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('Appointment will be requested for a'),
                  ),

                  // * Content
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 90,
                    child: CupertinoPicker(
                      squeeze: 0.9,
                      itemExtent: 36,
                      looping: true,
                      diameterRatio: 2,
                      onSelectedItemChanged: (index) {
                        _selectedSpecialist = index;
                        setState(() {});
                      },
                      children: [
                        for (String specialist in fieldSpl)
                          Center(child: Text(specialist)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// * Cupertino Date Picker: Date and Time
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
                  // * Title
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(Icons.schedule, size: 32),
                        const SizedBox(width: 10),
                        const Text('Date and Time',
                            style: TextStyle(fontSize: 20))
                      ],
                    ),
                  ),

                  // * Subtitle
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('Appointment will scheduled at'),
                  ),

                  // * Content
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: CupertinoDatePicker(
                      use24hFormat: true,
                      minuteInterval: 15,
                      initialDateTime:
                          now.add(Duration(minutes: 15 - now.minute % 15)),
                      onDateTimeChanged: (value) {
                        setState(
                          () {
                            _selectedTime = value;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// * Finalize and submit
          Card(
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
                          'Finalize and Submit',
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
                          hospital.text,
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
                          cardList[_selectedCard],
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
                          fieldSpl[_selectedSpecialist],
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
                          formattedDateTime(_selectedTime),
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
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
                      icon: const Icon(Icons.post_add),
                      label: const Text('Create Appointment'),
                      onPressed: () async {
                        await collectionReference
                            .add({
                              'hospital': hospital.text,
                              'appointee': cardList[_selectedCard],
                              'specialization': fieldSpl[_selectedSpecialist],
                              'dateTime': _selectedTime,
                            })
                            .then((value) => infoSnackbar(
                                'Success',
                                'Your appointment has been added to the database',
                                true))
                            .catchError((error) => infoSnackbar(
                                'Failed to add user', '$error', false));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
