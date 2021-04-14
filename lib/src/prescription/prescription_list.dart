// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Imports
// ⸻⸻⸻⸻⸻⸻⸻⸻
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
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

  final String identifier, timestamp, submitterName, submitterOrg;
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
                timestamp,
                style: const TextStyle(fontSize: 12),
              ),

              // * Name of submitter + icon
              Row(
                children: [
                  Text(
                    submitterName,
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
                submitterOrg,
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
                              labelText: 'Name Of Medicine #${index + 1}',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Swiper(
            itemCount: 3,
            control: SwiperControl(
                color: ThemeServie().isSavedDarkMode()
                    ? Colors.white
                    : Colors.blue),
            itemBuilder: (_, index) {
              return SingleChildScrollView(
                child: PrescriptionCard(
                    identifier: 'Firstname | 000${index + 1}',
                    timestamp: 'Saturday | April 10, 2021',
                    submitterName: 'Dr. XYZ',
                    submitterOrg: 'ABC Hospital',
                    submitterVerified: true,
                    medicineList: [
                      'Asprin 500mg',
                      'Antibiotic 650mg',
                      'Detoxer 10mg',
                      'ORS Solution',
                      'Eyedrops',
                    ],
                    medicineStats: [
                      [true, true, false, true],
                      [true, true, true, true],
                      [false, false, false, true],
                      [false, true, true, true],
                      [false, true, false, true],
                    ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
