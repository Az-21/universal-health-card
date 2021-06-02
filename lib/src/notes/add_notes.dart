// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_app/src/functions.dart';

// Pub Dev Imports
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:url_launcher/url_launcher.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Stateful Notes Creator
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class CreateNotesPage extends StatefulWidget {
  const CreateNotesPage({Key? key}) : super(key: key);

  @override
  _CreateNotesPageState createState() => _CreateNotesPageState();
}

class _CreateNotesPageState extends State<CreateNotesPage> {
  // * Variables
  double temp = 97.7;
  TextEditingController textTemp = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController bpS = TextEditingController();
  TextEditingController bpD = TextEditingController();
  String description = '## Symptoms\n---\n* \n* \n\n## Notes\n---\n* \n* \n';
  final String _markdownURL = 'https://www.markdownguide.org/cheat-sheet/';

  final _getStorage = GetStorage();

  // * Google hooks
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('notes');

  List<String> cardList = [
    'Abhijit | xxxx xxxx 0002',
    'Abhishek | xxxx xxxx 0003',
    'Amogh | xxxx xxxx 0009',
    'Dhruv | xxxx xxxx 0015',
  ];
  int _selectedCard = 0;

  // * Details of submitter
  String name = 'ERR: Unknown User';
  String orgnization = 'Self';
  bool isDoctor = false;
  @override
  void initState() {
    super.initState();
    // * Get details about current user
    orgnization = _getStorage.read('orgnization').toString();
    isDoctor =
        // ignore: avoid_bool_literals_in_conditional_expressions
        _getStorage.read('isDoc').toString() == 'true' ? true : false;
    name = user.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// * Cupertino picker: pick card
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
                          child: const Text('Medical note will be made for'),
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

                /// * Temperature
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
                              const Icon(Icons.device_thermostat, size: 32),
                              const SizedBox(width: 10),
                              const Text('Temperature',
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ),

                        // * Subtitle
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Text('Temperature of patient'),
                        ),

                        // * Content
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            /// * Slider Temperature
                            Expanded(
                              flex: 9,
                              child: SfLinearGauge(
                                // * Range
                                minimum: 95,
                                maximum: 103,

                                // * Triangle Marker + Text Display
                                markerPointers: [
                                  LinearShapePointer(
                                    value: temp,
                                    onValueChanged: (value) {
                                      setState(() {
                                        temp = double.parse(value.toString());
                                      });
                                    },
                                    color: Colors.blue[800],
                                  ),
                                  LinearWidgetPointer(
                                    value: temp,
                                    onValueChanged: (value) {
                                      setState(() {
                                        temp = double.parse(value.toString());
                                      });
                                      // Update textfield with slider
                                      textTemp.text = temp.toStringAsFixed(1);
                                    },
                                    position: LinearElementPosition.outside,
                                    child: SizedBox(
                                      width: 40,
                                      height: 60,
                                      child: Center(
                                        child: Text(
                                          '${temp.toStringAsFixed(1)} °F',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11,
                                              color: temp < 97
                                                  ? Colors.blue
                                                  : temp < 98.7
                                                      ? Colors.green
                                                      : Colors.red),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],

                                // * Gradient Axis
                                axisTrackStyle: const LinearAxisTrackStyle(
                                  thickness: 18,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue,
                                      Colors.green,
                                      Colors.red
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            /// * Text Temperature
                            Expanded(
                              flex: 3,
                              child: TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^\-?\d*\.?\d*)')),
                                ],
                                controller: textTemp,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: '°F',
                                  hintText: '97.7',
                                ),
                                onSubmitted: (value) {
                                  if (value == '' || value == '-') {
                                    textTemp.text = '97.7';
                                    setState(() => temp = 97.7);
                                  } else {
                                    temp = double.parse(value);
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                //// * Vitals
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
                              const Icon(Icons.graphic_eq, size: 32),
                              const SizedBox(width: 10),
                              const Text('Vitals',
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ),

                        // * Subtitle
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child:
                              const Text('Weight, height, and BP of patient'),
                        ),

                        /// * Weight and height
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^\-?\d*\.?\d*)')),
                                ],
                                controller: weight,
                                onSubmitted: (value) {
                                  setState(() {});
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Weight (kg)',
                                  hintText: '70',
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^\-?\d*\.?\d*)')),
                                ],
                                controller: height,
                                onSubmitted: (value) {
                                  setState(() {});
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Height (cm)',
                                  hintText: '160',
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// * BP
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^\-?\d*\.?\d*)')),
                                ],
                                controller: bpS,
                                onSubmitted: (value) {
                                  setState(() {});
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Systolic (mmHg)',
                                  hintText: '120',
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^\-?\d*\.?\d*)')),
                                ],
                                controller: bpD,
                                onSubmitted: (value) {
                                  setState(() {});
                                },
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Diastolic (mmHg)',
                                  hintText: '80',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                /// * Notes
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
                              const Icon(Icons.note_add, size: 32),
                              const SizedBox(width: 10),
                              const Text('Medical Note',
                                  style: TextStyle(fontSize: 20))
                            ],
                          ),
                        ),

                        // * Subtitle
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              primary: Colors.blue,
                              elevation: 3,
                            ),
                            icon: const Icon(Icons.code),
                            label: const Text('Markdown Syntax Guide'),
                            onPressed: _launchURL,
                          ),
                        ),

                        // * Content
                        const SizedBox(height: 10),
                        MarkdownTextInput(
                          (String value) => setState(() => description = value),
                          description,
                          label: 'Click on `< >` button for help',
                          maxLines: 14,
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
                                'Review and Submit',
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
                                'Patient ID',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            /// Temp
                            ListTile(
                              leading: const Icon(
                                Icons.device_thermostat,
                                color: Colors.white,
                              ),
                              title: Text(
                                '${textTemp.text} °C',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: const Text(
                                'Temperature',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            /// Weight
                            ListTile(
                              leading: const Icon(
                                Icons.data_usage,
                                color: Colors.white,
                              ),
                              title: Text(
                                '${weight.text} kg',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: const Text(
                                'Weight',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            /// Height
                            ListTile(
                              leading: const Icon(
                                Icons.straighten,
                                color: Colors.white,
                              ),
                              title: Text(
                                '${height.text} cm',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: const Text(
                                'Height',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            /// Blood Pressure
                            ListTile(
                              leading: const Icon(
                                Icons.blur_on_outlined,
                                color: Colors.white,
                              ),
                              title: Text(
                                '${bpS.text} / ${bpD.text} (mmHg)',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: const Text(
                                'Blood Pressure',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            /// Live Preview
                            const ListTile(
                              leading: Icon(
                                Icons.note,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Notes',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Markdown(
                            data: description,
                            shrinkWrap: true,
                          ),
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
                            label: const Text('Create Health Note'),
                            onPressed: () async {
                              await collectionReference
                                  .add({
                                    'dateTime': DateTime.now(),
                                    'forUser': cardList[_selectedCard],
                                    'byUser': name,
                                    'orgnization': orgnization,
                                    'isDoctor': isDoctor,
                                    'temperature': textTemp.text,
                                    'height': height.text,
                                    'weight': weight.text,
                                    'bpS': bpS.text,
                                    'bpD': bpD.text,
                                    'note': description,
                                  })
                                  .then((value) => infoSnackbar(
                                      'Success',
                                      'Your medical note has been added to the database',
                                      true))
                                  .catchError((error) => infoSnackbar(
                                      'Failed to add medical note',
                                      '$error',
                                      false));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // * Launch Markdown Guide
  // ignore: avoid_void_async
  void _launchURL() async {
    await canLaunch(_markdownURL)
        ? await launch(_markdownURL)
        : throw 'Could not launch $_markdownURL';
  }
}
