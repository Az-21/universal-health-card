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
        margin: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                identifier,
                style: TextStyle(fontSize: 16),
              ),
              Divider(),
              // * Date
              Text(
                timestamp,
                style: TextStyle(fontSize: 12),
              ),

              // * Name of submitter + icon
              Row(
                children: [
                  Text(
                    submitterName,
                    style: TextStyle(fontSize: 14),
                  ),
                  Spacer(),
                  submitterVerified
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
                submitterOrg,
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
                              border: OutlineInputBorder(),
                              labelText: 'Name Of Medicine #${index + 1}',
                            ),
                          ),
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
                            onPressed: (int i) {},
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
  PrescriptionList({Key? key}) : super(key: key);

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
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Swiper(
            itemCount: 3,
            control: new SwiperControl(
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
