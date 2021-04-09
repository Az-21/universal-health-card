// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:health_app/src/functions.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Stateful Card UI
// ⸻⸻⸻⸻⸻⸻⸻⸻
class PrescriptionCardAdder extends StatefulWidget {
  PrescriptionCardAdder({Key? key}) : super(key: key);

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
  String nameOfSubmitter = 'Dr. XYZ';
  String orgOfSubmitter = 'ABC Hospital';
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
      /// * 2xFAB with logic
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(Icons.delete_forever),
            onPressed: () {
              if (_countMedicine == 1) {
                infoSnackbar(
                    'Warning', 'At least one medicine is required', false);
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

      /// * Body
      body: ListView(
        children: [
          // ⸻⸻⸻⸻⸻⸻⸻⸻
          // * Child: Health card selector
          // ⸻⸻⸻⸻⸻⸻⸻⸻
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
          // * Child: Medication
          // ⸻⸻⸻⸻⸻⸻⸻⸻
          /// * Title
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Prescription',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Divider(thickness: 2),
              ],
            ),
          ),

          /// * Card Body
          Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // * Date
                  Text(
                    formattedDate(),
                    style: TextStyle(fontSize: 12),
                  ),

                  // * Name of submitter + icon
                  Row(
                    children: [
                      Text(
                        nameOfSubmitter,
                        style: TextStyle(fontSize: 24),
                      ),
                      Spacer(),
                      isSubmitterDoctor
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
                    orgOfSubmitter,
                    style: TextStyle(fontSize: 12),
                  ),

                  // ⸻⸻⸻⸻⸻⸻⸻⸻
                  // * List of medicines in one unique prescription
                  // ⸻⸻⸻⸻⸻⸻⸻⸻
                  ListView(
                    padding: EdgeInsets.only(top: 20),
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: _countMedicine,
                        itemBuilder: (_, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // * Text
                              TextField(
                                  controller: medicineList[index],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name Of Medicine #${index + 1}',
                                    hintText: 'Asprin 500mg',
                                  ),
                                  onSubmitted: (value) {
                                    print('Medicine Name: $value');
                                  }),
                              // * Vertical padding
                              SizedBox(height: 5),

                              // * Row below textfield conaining toggles
                              ToggleButtons(
                                color: Colors.grey[500],
                                selectedColor: Colors.white,
                                fillColor: Colors.green,
                                children: [
                                  medicineStats[index][0]
                                      ? Icon(Icons.fastfood)
                                      : Icon(Icons.no_food),
                                  Icon(Icons.wb_twighlight),
                                  Icon(Icons.wb_sunny),
                                  Icon(Icons.nights_stay),
                                ],
                                isSelected: medicineStats[index],
                                onPressed: (int subindex) {
                                  setState(() {
                                    medicineStats[index][subindex] =
                                        !medicineStats[index][subindex];
                                  });
                                },
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            color: Colors.grey[500],
                            height: 20,
                          );
                        },
                      ),
                    ],
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
