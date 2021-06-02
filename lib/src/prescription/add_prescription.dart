// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

// Pub Dev Imports
import 'package:health_app/src/functions.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Stateful Card UI
// ⸻⸻⸻⸻⸻⸻⸻⸻
class PrescriptionCardAdder extends StatefulWidget {
  const PrescriptionCardAdder({Key? key}) : super(key: key);

  @override
  _PrescriptionCardAdderState createState() => _PrescriptionCardAdderState();
}

class _PrescriptionCardAdderState extends State<PrescriptionCardAdder> {
  final _getStorage = GetStorage();
  // * Google hooks
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('prescriptions');

  // * List of cards
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
    if (_getStorage.read('orgnization') == null) {
      _getStorage.write('orgnization', 'Self');
    }
    if (_getStorage.read('isDoc') == null) {
      _getStorage.write('isDoc', false);
    }

    // * Get details about current user
    orgnization = _getStorage.read('orgnization').toString();
    isDoctor =
        // ignore: avoid_bool_literals_in_conditional_expressions
        _getStorage.read('isDoc').toString() == 'true' ? true : false;
    name = user.displayName!;
  }

  // * Vars for checkbox
  List<List<bool>> medicineStats = [
    [true, true, true, true]
  ]; // [before and after food toggle, morning, afternoon, night] :: [[0,1,2,3]]

  // * Var for textfield
  List<TextEditingController> medicineList = [TextEditingController()];

  // ⸻⸻⸻⸻⸻⸻⸻⸻
  // * Function: Add Medicine Item
  // ⸻⸻⸻⸻⸻⸻⸻⸻
  int _countMedicine = 1;
  void _addItem() {
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
  void _removeItem() {
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
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            onPressed: () {
              if (_countMedicine == 1) {
                infoSnackbar(
                    'Warning', 'At least one medicine is required', false);
              } else {
                _removeItem();
              }
            },
            child: const Icon(Icons.delete_forever),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            onPressed: () {
              _addItem();
            },
            child: const Icon(Icons.playlist_add),
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    onSelectedItemChanged: (index) {
                      _selectedCard = index;
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

          // ⸻⸻⸻⸻⸻⸻⸻⸻
          // * Child: Medication
          // ⸻⸻⸻⸻⸻⸻⸻⸻
          /// * Title
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Prescription',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Divider(thickness: 2),
              ],
            ),
          ),

          /// * Card Body
          Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // * Date
                  Text(
                    formattedDate(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w200),
                  ),

                  // * Prescribed by
                  const SizedBox(height: 10),
                  const Text(
                    'Prescribed by',
                    style: TextStyle(fontSize: 12),
                  ),

                  // * Name of submitter + icon
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      if (isDoctor)
                        const Icon(
                          Icons.verified,
                          size: 40,
                          color: Colors.green,
                        )
                      else
                        const Icon(
                          Icons.supervised_user_circle,
                          size: 40,
                          color: Colors.blue,
                        )
                    ],
                  ),
                  // * Orgnization of submitter
                  Text(
                    'Orgnization: $orgnization',
                    style: const TextStyle(fontSize: 12),
                  ),

                  // ⸻⸻⸻⸻⸻⸻⸻⸻
                  // * List of medicines in one unique prescription
                  // ⸻⸻⸻⸻⸻⸻⸻⸻
                  ListView(
                    padding: const EdgeInsets.only(top: 20),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: _countMedicine,
                        itemBuilder: (_, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // * Text
                              TextField(
                                  controller: medicineList[index],
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: 'Name Of Medicine #${index + 1}',
                                    hintText: 'Asprin 500mg',
                                  ),
                                  onSubmitted: (value) {}),
                              // * Vertical padding
                              const SizedBox(height: 5),

                              // * Row below textfield conaining toggles
                              ToggleButtons(
                                color: Colors.grey[500],
                                selectedColor: Colors.white,
                                fillColor: Colors.green,
                                isSelected: medicineStats[index],
                                onPressed: (int subindex) {
                                  setState(() {
                                    medicineStats[index][subindex] =
                                        !medicineStats[index][subindex];
                                  });
                                },
                                children: [
                                  if (medicineStats[index][0])
                                    const Icon(Icons.fastfood)
                                  else
                                    const Icon(Icons.no_food),
                                  const Icon(Icons.wb_twighlight),
                                  const Icon(Icons.wb_sunny),
                                  const Icon(Icons.nights_stay),
                                ],
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

          // * Create button
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                primary: Colors.green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                // minimumSize: Size(200, 100),
              ),
              icon: const Icon(Icons.post_add),
              label: const Text('Create Prescription'),
              onPressed: () async {
                await collectionReference
                    .add({
                      'forUser': cardList[_selectedCard],
                      'dateTime': DateTime.now(),
                      'byUser': user.displayName!,
                      'orgnization': orgnization,
                      'isDoctor': isDoctor,
                      'medicines': processedMedicineList(medicineList),
                      'dosage': processedMedicineStats(medicineStats),
                    })
                    .then((value) => infoSnackbar(
                        'Success', 'Prescription added to the database', true))
                    .catchError((error) => infoSnackbar(
                        'Failed to add prescription', '$error', false));
              },
            ),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }

  // * TextEditingController List -> String List
  List<String> processedMedicineList(List<TextEditingController> medicineList) {
    final List<String> meds = [];
    for (var i = 0; i < medicineList.length; i++) {
      meds.add(medicineList[i].text);
    }
    return meds;
  }

  // * Flatten the List<List<bool>> -> 1s and 0s
  String processedMedicineStats(List<List<bool>> medicineStats) {
    final buffer = StringBuffer();
    for (var i = 0; i < medicineStats.length; i++) {
      for (var j = 0; j < 4; j++) {
        if (medicineStats[i][j] == true) {
          buffer.write('1 ');
        } else {
          buffer.write('0 ');
        }
      }
    }
    return buffer.toString();
  }
}
