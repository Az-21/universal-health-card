// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Stateful Card UI
// ⸻⸻⸻⸻⸻⸻⸻⸻
class PrescriptionCardAdder extends StatefulWidget {
  PrescriptionCardAdder({Key key}) : super(key: key);

  @override
  _PrescriptionCardAdderState createState() => _PrescriptionCardAdderState();
}

class _PrescriptionCardAdderState extends State<PrescriptionCardAdder> {
  //* Details of submitter
  String nameOfSubmitter = 'Dr. Prem';
  bool isSubmitterDoctor = true;

  //* Vars for checkbox
  List<bool> _bfafToggleList = [true];
  List<bool> isCheckedMList = [true];
  List<bool> isCheckedAList = [true];
  List<bool> isCheckedNList = [true];

  // * Var for textfield
  List<TextEditingController> medicineList = [TextEditingController()];

  // ⸻⸻⸻⸻⸻⸻⸻⸻
  // * Function: Add Medicine Item
  // ⸻⸻⸻⸻⸻⸻⸻⸻
  int _countMedicine = 1;
  _addItem() {
    setState(() {
      // * Increase length of list
      _bfafToggleList.add(true);
      isCheckedMList.add(true);
      isCheckedAList.add(true);
      isCheckedNList.add(true);
      medicineList.add(TextEditingController());
      _countMedicine++;
    });
  }

  // ⸻⸻⸻⸻⸻⸻⸻⸻
  // * Function: Delete Medicine Item
  // ⸻⸻⸻⸻⸻⸻⸻⸻
  _removeItem() {
    setState(() {
      _bfafToggleList.removeLast();
      isCheckedMList.removeLast();
      isCheckedAList.removeLast();
      isCheckedNList.removeLast();
      medicineList.removeLast();
      _countMedicine--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(Icons.delete_forever),
            onPressed: () {
              if (_countMedicine == 1) {
                // TODO: add toast message when called
              } else {
                _removeItem();
              }
            },
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.playlist_add),
            onPressed: () {
              _addItem();
            },
          )
        ],
      ),
      body: ListView(
        children: [
          // ⸻⸻⸻⸻⸻⸻⸻⸻
          // * Child #1: Card
          // ⸻⸻⸻⸻⸻⸻⸻⸻
          GFCard(
            title: GFListTile(
              // * Title
              title: Text(
                formattedDate(),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              // * Subtitle
              subtitle: Text(
                nameOfSubmitter,
                style: TextStyle(fontSize: 24),
              ),
              icon: isSubmitterDoctor
                  ? Icon(Icons.verified)
                  : Icon(Icons.do_not_disturb_on),
            ),
            // ⸻⸻⸻⸻⸻⸻⸻⸻
            // * List of medicines in one unique prescription
            // ⸻⸻⸻⸻⸻⸻⸻⸻
            content: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: _countMedicine,
                  itemBuilder: (_, int index) {
                    return Column(
                      children: [
                        // * Text
                        TextField(
                            controller: medicineList[index],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name Of Medicine',
                              hintText: 'Asprin 500mg',
                            ),
                            onSubmitted: (value) {
                              print('Medicine Name: $value');
                            }),
                        // * Vertical padding
                        SizedBox(height: 10),

                        // * Row below textfield conaining toggles
                        Row(
                          children: [
                            // * Before/after food toggle
                            Transform.scale(
                              scale: 1.2,
                              child: CupertinoSwitch(
                                value: _bfafToggleList[index],
                                onChanged: (bool value) {
                                  setState(() {
                                    _bfafToggleList[index] = value;
                                  });
                                },
                              ),
                            ),

                            // * Horizontal padding
                            SizedBox(width: 100),

                            /// * Morning checkbox
                            Expanded(
                              child: GFCheckbox(
                                activeIcon: Icon(Icons.wb_sunny_outlined,
                                    color: Colors.white),
                                inactiveIcon: Icon(Icons.wb_sunny_outlined,
                                    color: Colors.grey[500]),
                                // type: GFCheckboxType.circle,
                                size: GFSize.LARGE,
                                activeBgColor: Colors.green,
                                onChanged: (value) {
                                  setState(() {
                                    isCheckedMList[index] = value;
                                  });
                                },
                                value: isCheckedMList[index],
                              ),
                            ),

                            // * Horizontal padding
                            SizedBox(width: 10),

                            /// * Afternoon checkbox
                            Expanded(
                              child: GFCheckbox(
                                activeIcon:
                                    Icon(Icons.wb_sunny, color: Colors.white),
                                inactiveIcon: Icon(Icons.wb_sunny,
                                    color: Colors.grey[500]),
                                // type: GFCheckboxType.circle,
                                size: GFSize.LARGE,
                                activeBgColor: Colors.orange,
                                onChanged: (value) {
                                  setState(() {
                                    isCheckedAList[index] = value;
                                  });
                                },
                                value: isCheckedAList[index],
                              ),
                            ),

                            // * Horizontal padding
                            SizedBox(width: 10),

                            /// * Night checkbox
                            Expanded(
                              child: GFCheckbox(
                                activeIcon: Icon(Icons.nights_stay,
                                    color: Colors.white),
                                inactiveIcon: Icon(Icons.nights_stay,
                                    color: Colors.grey[500]),
                                // type: GFCheckboxType.circle,
                                size: GFSize.LARGE,
                                activeBgColor: Colors.indigo,
                                onChanged: (value) {
                                  setState(() {
                                    isCheckedNList[index] = value;
                                  });
                                },
                                value: isCheckedNList[index],
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(height: 20);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// April 2, 2021
String formattedDate() {
  var now = DateTime.now();
  String date = '';

  // Task: format the output like
  // April 02, 2021

  date = DateFormat('EEEE | dd MMMM, yyyy').format(
      now); // EEEE gives the day of the week, dd gives the day, MMMM dives the month and yyyy gives the year
  return '${date}';
}
