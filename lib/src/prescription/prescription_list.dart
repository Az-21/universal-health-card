// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Imports
// ⸻⸻⸻⸻⸻⸻⸻⸻
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:health_app/src/functions.dart';
import 'package:health_app/theme/theme_service.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Reusable widget skeleton
// ⸻⸻⸻⸻⸻⸻⸻⸻
class PrescriptionCard extends StatelessWidget {
  const PrescriptionCard({
    Key? key,
    required this.identifier,
    required this.timestamp,
    required this.submitterName,
    required this.submitterOrg,
    required this.submitterVerified,
    required this.medicineList,
    required this.medicineStats,
  }) : super(key: key);

  final String identifier, submitterName, submitterOrg;
  final DateTime timestamp;
  final bool submitterVerified;
  final List<String> medicineList;
  final List<List<bool>> medicineStats;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                identifier,
                style: const TextStyle(fontSize: 16),
              ),
              const Divider(),
              // * Date
              Text(
                formattedDateTime(timestamp),
                style: const TextStyle(fontSize: 12),
              ),

              // * Name of submitter + icon
              Row(
                children: [
                  Text(
                    'Prescribed by $submitterName',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  if (submitterVerified)
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
                'Orgnization: $submitterOrg',
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
                    itemCount: medicineList.length,
                    itemBuilder: (_, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // * Text
                          TextFormField(
                            initialValue: medicineList[index],
                            enabled: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Medicine #${index + 1}',
                            ),
                          ),
                          // * Vertical padding
                          const SizedBox(height: 5),

                          // * Row below textfield conaining toggles
                          ToggleButtons(
                            color: Colors.grey[500],
                            selectedColor: Colors.white,
                            fillColor: Colors.green,
                            isSelected: medicineStats[index],
                            onPressed: (int i) {},
                            children: [
                              if (medicineStats[index][0])
                                const Icon(Icons.fastfood)
                              else
                                const Icon(Icons.no_food),
                              const Icon(Icons.wb_twighlight),
                              const Icon(Icons.wb_sunny),
                              const Icon(Icons.nights_stay),
                            ],
                            // ^ widget becomes inactive without this line
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
        ));
  }
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Appointment Card List
// ⸻⸻⸻⸻⸻⸻⸻⸻
class PrescriptionList extends StatefulWidget {
  const PrescriptionList({Key? key}) : super(key: key);

  @override
  _PrescriptionListState createState() => _PrescriptionListState();
}

class _PrescriptionListState extends State<PrescriptionList> {
  // * Firestore hook
  CollectionReference prescriptions =
      FirebaseFirestore.instance.collection('prescriptions');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: StreamBuilder(
            stream: prescriptions.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return Swiper(
                  itemCount: snapshot.data!.docs.length,
                  control: SwiperControl(
                    color: ThemeServie().isSavedDarkMode()
                        ? Colors.white
                        : Colors.blue,
                  ),
                  itemBuilder: (_, index) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: PrescriptionCard(
                        identifier:
                            snapshot.data!.docs[index]['forUser'].toString(),
                        timestamp: DateTime.parse(snapshot
                            .data!.docs[index]['dateTime']
                            .toDate()
                            .toString()),
                        submitterName:
                            snapshot.data!.docs[index]['byUser'].toString(),
                        submitterOrg: snapshot.data!.docs[index]['orgnization']
                            .toString(),
                        submitterVerified:
                            // ignore: avoid_bool_literals_in_conditional_expressions
                            snapshot.data!.docs[index]['isDoctor'].toString() ==
                                    'true'
                                ? true
                                : false,
                        medicineList: processedMedicineList(snapshot
                            .data!.docs[index]['medicines'] as List<dynamic>),
                        medicineStats: processedDosage(
                            snapshot.data!.docs[index]['dosage'].toString()),
                      ),
                    );
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  // * Processed medicine list
  List<String> processedMedicineList(List<dynamic> cloudInput) {
    final List<String> medicineList = [];
    for (var i = 0; i < cloudInput.length; i++) {
      medicineList.add(cloudInput[i].toString());
    }

    return medicineList;
  }

  // * Unflatten the dosage list
  List<List<bool>> processedDosage(String flatDosageList) {
    final List<List<bool>> dosage = [];
    final List<String> splitDosageList = flatDosageList.split(' ');
    splitDosageList.removeLast(); // removes last empty element

    for (var i = 0; i < splitDosageList.length ~/ 4; i++) {
      final List<bool> singleMedDosage = [];
      for (var j = 0; j < 4; j++) {
        if (splitDosageList[i + j] == '1') {
          singleMedDosage.add(true);
        } else {
          singleMedDosage.add(false);
        }
      }

      dosage.add(singleMedDosage);
    }

    return dosage;
  }
}
