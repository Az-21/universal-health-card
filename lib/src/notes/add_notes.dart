// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  double temp = 36.5;
  TextEditingController textTemp = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController bpS = TextEditingController();
  TextEditingController bpD = TextEditingController();
  String description = '# Symptoms\n---\n* \n* \n\n# Notes\n---\n* \n* \n';
  final String _markdownURL = 'https://www.markdownguide.org/cheat-sheet/';

  List<String> cardList = [
    'Abhijit | xxxx xxxx 0002',
    'Abhishek | xxxx xxxx 0003',
    'Amogh | xxxx xxxx 0009',
    'Dhruv | xxxx xxxx 0015',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// * Cupertino Picker: Pick Card
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

                // ⸻⸻⸻⸻⸻⸻⸻⸻
                // * Child: Temperature Slider + Text
                // ⸻⸻⸻⸻⸻⸻⸻⸻
                const SizedBox(height: 32),
                const Text(
                  'Temperature',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Divider(thickness: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    /// * Slider Temperature
                    Expanded(
                      flex: 9,
                      child: SfLinearGauge(
                        // * Range
                        minimum: 35,
                        maximum: 39,

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
                              textTemp.text = value.toString();
                            },
                            position: LinearElementPosition.outside,
                            child: SizedBox(
                              width: 40,
                              height: 60,
                              child: Center(
                                child: Text(
                                  '${temp.toStringAsFixed(1)} °C',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11,
                                      color: temp < 36.1
                                          ? Colors.blue
                                          : temp < 37.2
                                              ? Colors.green
                                              : Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ],

                        // * Gradient Axis
                        axisTrackStyle: LinearAxisTrackStyle(
                          thickness: 18,
                          gradient: const LinearGradient(
                            colors: [Colors.blue, Colors.green, Colors.red],
                          ),
                        ),
                      ),
                    ),

                    /// * Text Temperature
                    Expanded(
                      flex: 3,
                      child: TextField(
                        /// ! TODO: catch null errors!!!
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\-?\d*\.?\d*)')),
                        ],
                        controller: textTemp,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '°C',
                          hintText: '36.5',
                        ),
                        onSubmitted: (value) {
                          temp = double.parse(value);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                // ⸻⸻⸻⸻⸻⸻⸻⸻
                // * Child: Weight and Height
                // ⸻⸻⸻⸻⸻⸻⸻⸻
                const SizedBox(height: 32),
                const Text(
                  'Weight and Height',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Divider(thickness: 2),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\-?\d*\.?\d*)')),
                        ],
                        controller: weight,
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\-?\d*\.?\d*)')),
                        ],
                        controller: height,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Height (cm)',
                          hintText: '160',
                        ),
                      ),
                    ),
                  ],
                ),

                // ⸻⸻⸻⸻⸻⸻⸻⸻
                // * Child: Blood Pressure
                // ⸻⸻⸻⸻⸻⸻⸻⸻
                const SizedBox(height: 32),
                const Text(
                  'Blood Pressure',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Divider(thickness: 2),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\-?\d*\.?\d*)')),
                        ],
                        controller: bpS,
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\-?\d*\.?\d*)')),
                        ],
                        controller: bpD,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Diastolic (mmHg)',
                          hintText: '80',
                        ),
                      ),
                    ),
                  ],
                ),

                // ⸻⸻⸻⸻⸻⸻⸻⸻
                // * Child: Notes
                // ⸻⸻⸻⸻⸻⸻⸻⸻
                const SizedBox(height: 32),
                Row(
                  children: [
                    const Expanded(
                      flex: 9,
                      child: Text(
                        'Symptoms and Notes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary: Colors.blue,
                        ),
                        icon: const Icon(Icons.code),
                        label: const Text('Syntax'),
                        onPressed: _launchURL,
                      ),
                    ),
                  ],
                ),
                const Divider(thickness: 2),
                Column(
                  children: [
                    MarkdownTextInput(
                      (String value) => setState(() => description = value),
                      description,
                      label: 'Click on `< > Syntax` button for help',
                      maxLines: 14,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '📑 Live Preview',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Card(
                      elevation: 10,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Markdown(
                          data: description,
                          shrinkWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      // minimumSize: Size(200, 100),
                    ),
                    icon: const Icon(Icons.save),
                    label: const Text('Save Health Note'),
                    onPressed: () {},
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
