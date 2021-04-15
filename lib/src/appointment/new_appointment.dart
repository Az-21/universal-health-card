import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CreateAppointmentPage extends StatefulWidget {
  const CreateAppointmentPage({Key? key}) : super(key: key);

  @override
  _CreateAppointmentPageState createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  // * Vars

  List<String> cardList = [
    'Abhijit | xxxx xxxx 0002',
    'Abhishek | xxxx xxxx 0003',
    'Amogh | xxxx xxxx 0009',
    'Dhruv | xxxx xxxx 0015',
  ];

  List<String> fieldSpl = [
    'GP',
    'ENT',
    'Pediatrist',
    'Cardiologist',
    'Opthamologist',
    'Neurologist',
  ];

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(
          Icons.post_add_rounded,
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          /// * TextField: Name of Hospital
          const SizedBox(height: 20),
          const Text(
            'Select Hospital',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Divider(thickness: 2),
          TextField(
            // controller: myController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name of Hospital',
              hintText: 'MS Ramaiah Hospital',
              icon: Icon(Icons.local_hospital_outlined),
            ),
            onSubmitted: (value) {
              //setState(() {});
            },
          ),

          /// * Cupertino Picker: Pick Card
          const SizedBox(height: 32),
          const Text(
            'Select Health Card',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Divider(thickness: 2),
          SizedBox(
            height: 90,
            child: CupertinoPicker(
              squeeze: 0.9,
              itemExtent: 36,
              looping: true,
              diameterRatio: 2,
              onSelectedItemChanged: (index) {},
              children: [
                for (String cardNumber in cardList)
                  Center(child: Text(cardNumber)),
              ],
            ),
          ),

          /// * Cupertino Picker: Specialist
          const SizedBox(height: 32),
          const Text(
            'Select Specialization',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Divider(thickness: 2),
          SizedBox(
            height: 90,
            child: CupertinoPicker(
              squeeze: 0.9,
              itemExtent: 36,
              looping: true,
              diameterRatio: 2,
              onSelectedItemChanged: (index) {},
              children: [
                for (String specialist in fieldSpl)
                  Center(child: Text(specialist)),
              ],
            ),
          ),

          /// * Cupertino Date Picker: Date and Time
          const SizedBox(height: 32),
          const Text(
            'Select Appointment Time',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Divider(thickness: 2),
          SizedBox(
            height: 120,
            child: CupertinoDatePicker(
              use24hFormat: true,
              minuteInterval: 15,
              initialDateTime: now.add(Duration(minutes: 15 - now.minute % 15)),
              onDateTimeChanged: (value) {
                setState(
                  () {
                    // TODO: DateTime _selectedTime = value;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
