import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CreateAppointmentPage extends StatefulWidget {
  CreateAppointmentPage({Key? key}) : super(key: key);

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
  DateTime? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.post_add_rounded,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          /// * TextField: Name of Hospital
          SizedBox(height: 20),
          Text(
            'Select Hospital',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(thickness: 2),
          TextField(
            // controller: myController,
            decoration: InputDecoration(
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
          SizedBox(height: 32),
          Text(
            'Select Health Card',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(thickness: 2),
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
          SizedBox(height: 32),
          Text(
            'Select Specialization',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(thickness: 2),
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
                  Center(
                    child: Text(specialist),
                  ),
              ],
            ),
          ),

          /// * Cupertino Date Picker: Date and Time
          SizedBox(height: 32),
          Text(
            'Select Appointment Time',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(thickness: 2),
          SizedBox(
            height: 120,
            child: CupertinoDatePicker(
              use24hFormat: true,
              minuteInterval: 15,
              initialDateTime: now.add(Duration(minutes: 15 - now.minute % 15)),
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
    );
  }
}
