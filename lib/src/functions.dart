import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function: Print Day | Date
// ⸻⸻⸻⸻⸻⸻⸻⸻
String formattedDate() {
  DateTime now = DateTime.now();
  // EEEE gives the day of the week
  // dd gives the day
  // MMMM dives the month
  // yyyy gives the year

  return DateFormat('EEEE | MMMM dd, yyyy').format(now);
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function: Print Time | Day | Date
// ⸻⸻⸻⸻⸻⸻⸻⸻
String formattedDateTime(DateTime time) {
  // EEEE gives the day of the week
  // dd gives the day
  // MMMM dives the month
  // yyyy gives the year

  return DateFormat('MMMM dd  | ').add_jm().format(time);
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Function: Snackbar
// ⸻⸻⸻⸻⸻⸻⸻⸻
void infoSnackbar(String title, String subtitle, bool success) {
  Get.snackbar(
    '$title',
    '$subtitle',
    icon: success
        ? Icon(Icons.done_all, color: Colors.white)
        : Icon(Icons.error_outline, color: Colors.white),
    shouldIconPulse: true,
    colorText: Colors.white,
    barBlur: 2,
    backgroundColor: success ? Colors.green : Colors.redAccent,
    isDismissible: true,
    duration: Duration(seconds: 5),
  );
}

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Reused widget: image card launcher
// ⸻⸻⸻⸻⸻⸻⸻⸻
class ImageFunctionCard extends StatelessWidget {
  const ImageFunctionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.imagePath,
    required this.url,
    required this.isMap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final IconData icon;
  final String imagePath;
  final String url;
  final bool isMap; // 1 = map, 0 = search

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                imagePath,
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // * Title
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        icon,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(width: 10),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 10),

                // * Subtitle
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    subtitle,
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                SizedBox(height: 32),

                // * Action
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      // minimumSize: Size(200, 100),
                    ),
                    icon: Icon(Icons.launch),
                    label: Text('Launch'),
                    onPressed: () {
                      _launchURL(url, isMap);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url, bool isMap) {
    isMap ? _launchMaps() : _launchGoogleSearch();
  }

  // * Function: launch maps
  void _launchMaps() => MapsLauncher.launchQuery(url);

  // * Function: launch search
  void _launchGoogleSearch() async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
