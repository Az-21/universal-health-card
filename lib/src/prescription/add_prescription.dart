// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:getwidget/getwidget.dart';
import 'package:get/get.dart';
import 'package:health_app/src/functions.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Stateful Card UI
// ⸻⸻⸻⸻⸻⸻⸻⸻
class PrescriptionCardAdder extends StatefulWidget {
  PrescriptionCardAdder({Key key}) : super(key: key);

  @override
  _PrescriptionCardAdderState createState() => _PrescriptionCardAdderState();
}

class _PrescriptionCardAdderState extends State<PrescriptionCardAdder> {
  // * List of cards
  List<String> cardList = [
    'Abhijit | xxxx xxxx 0002',
    'Abhishek | xxxx xxxx 0003',
    'Amogh | xxxx xxxx 0009',
    'Dhruv | xxxx xxxx 0015',
  ];

  //* Details of submitter
  String nameOfSubmitter = 'Dr. Prem';
  bool isSubmitterDoctor = true;

  //* Vars for checkbox
  List<List<bool>> medicineStats = [
    [true, true, true, true]
  ]; // [before and after food toggle, morning, afternoon, night] :: [[0,1,2,3]]

  // * Var for textfield
  List<TextEditingController> medicineList = [TextEditingController()];

  // ⸻⸻⸻⸻⸻⸻⸻⸻
  // * Function: Add Medicine Item
  // ⸻⸻⸻⸻⸻⸻⸻⸻
  int _countMedicine = 1;
  _addItem() {
    setState(() {
      // * Increase length of list
      medicineStats.add([true, true, true, true]);
      medicineList.add(TextEditingController());
      _countMedicine++;
    });
  }

  // ⸻⸻⸻⸻⸻⸻⸻⸻
  // * Function: Delete Medicine Item
  // ⸻⸻⸻⸻⸻⸻⸻⸻
  _removeItem() {
    setState(() {
      medicineStats.removeLast();
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
                Get.snackbar(
                  'Warning',
                  'Atleast one medicine is required',
                  barBlur: 20,
                  shouldIconPulse: true,
                  icon: Icon(Icons.warning),
                  colorText: Colors.white,
                  backgroundColor: Colors.redAccent,
                  snackPosition: SnackPosition.TOP,
                );
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
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              ],
            ),
          ),
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
                                value: medicineStats[index][0],
                                onChanged: (bool value) {
                                  setState(() {
                                    medicineStats[index][0] = value;
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
                                    medicineStats[index][1] = value;
                                  });
                                },
                                value: medicineStats[index][1],
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
                                    medicineStats[index][2] = value;
                                  });
                                },
                                value: medicineStats[index][2],
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
                                    medicineStats[index][3] = value;
                                  });
                                },
                                value: medicineStats[index][3],
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
