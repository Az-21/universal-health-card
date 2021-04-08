// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Pub Dev Imports
import 'package:getwidget/getwidget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ⸻⸻⸻⸻⸻⸻⸻⸻
                // * Child: Temperature Slider + Text
                // ⸻⸻⸻⸻⸻⸻⸻⸻
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
                      flex: 5,
                      child: GFButton(
                        onPressed: _launchURL,
                        child: Text('Syntax'),
                        icon: Icon(Icons.code, color: Colors.white),
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
                      label: 'Description',
                      maxLines: 14,
                    ),
                    SizedBox(height: 16),
                    Text(
                      '✨ Live Preview ✨',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GFCard(
                      elevation: 20,
                      content: Markdown(
                        data: description,
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: GFButton(
                    text: 'Save Health Note',
                    size: GFSize.LARGE,
                    elevation: 5,
                    color: Colors.green,
                    splashColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    icon: Icon(
                      Icons.cloud_upload,
                      color: Colors.white,
                    ),
                    // TODO: add logic
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
