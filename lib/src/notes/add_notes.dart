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
  CreateNotesPage({Key key}) : super(key: key);

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

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// * Cupertino Picker: Pick Card
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

                // ⸻⸻⸻⸻⸻⸻⸻⸻
                // * Child: Temperature Slider + Text
                // ⸻⸻⸻⸻⸻⸻⸻⸻
                SizedBox(height: 32),
                Text(
                  'Temperature',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Divider(thickness: 2),
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
                                temp = value;
                              });
                            },
                            color: Colors.blue[800],
                          ),
                          LinearWidgetPointer(
                            value: temp,
                            onValueChanged: (value) {
                              setState(() {
                                temp = value;
                              });
                              // Update textfield with slider
                              textTemp.text = value.toStringAsFixed(1);
                            },
                            child: Container(
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
                            position: LinearElementPosition.outside,
                          ),
                        ],

                        // * Gradient Axis
                        axisTrackStyle: LinearAxisTrackStyle(
                          thickness: 18,
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.green, Colors.red],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            tileMode: TileMode.clamp,
                          ),
                        ),
                      ),
                    ),

                    /// * Text Temperature
                    Expanded(
                      flex: 3,
                      child: TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\-?\d*\.?\d*)')),
                        ],
                        controller: textTemp,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '°C',
                          hintText: '36.5',
                        ),
                        onSubmitted: (value) {
                          temp = double.tryParse(value);
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),

                // ⸻⸻⸻⸻⸻⸻⸻⸻
                // * Child: Weight and Height
                // ⸻⸻⸻⸻⸻⸻⸻⸻
                SizedBox(height: 32),
                Text(
                  'Weight and Height',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Divider(thickness: 2),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\-?\d*\.?\d*)')),
                        ],
                        controller: weight,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Weight (kg)',
                          hintText: '70',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\-?\d*\.?\d*)')),
                        ],
                        controller: height,
                        decoration: InputDecoration(
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
                SizedBox(height: 32),
                Text(
                  'Blood Pressure',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Divider(thickness: 2),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\-?\d*\.?\d*)')),
                        ],
                        controller: bpS,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Systolic (mmHg)',
                          hintText: '120',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'(^\-?\d*\.?\d*)')),
                        ],
                        controller: bpD,
                        decoration: InputDecoration(
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
                SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
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
                        icon: Icon(Icons.code),
                        label: Text('Syntax'),
                        onPressed: _launchURL,
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 2),
                Column(
                  children: [
                    MarkdownTextInput(
                      (String value) => setState(() => description = value),
                      description,
                      label: 'Click on `< > Syntax` button for help',
                      maxLines: 14,
                    ),
                    SizedBox(height: 16),
                    Text(
                      '📑 Live Preview',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Card(
                      elevation: 10,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      // minimumSize: Size(200, 100),
                    ),
                    icon: Icon(Icons.save),
                    label: Text('Save Health Note'),
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
  void _launchURL() async => await canLaunch(_markdownURL)
      ? await launch(_markdownURL)
      : throw 'Could not launch $_markdownURL';
}
