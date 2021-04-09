// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';

// ⸻⸻⸻⸻⸻⸻⸻⸻
// * Stateless URL Launcher
// ⸻⸻⸻⸻⸻⸻⸻⸻
class HospitalLocator extends StatelessWidget {
  const HospitalLocator({Key key}) : super(key: key);

  final String _url = 'https://www.google.com/search?q=hospital+near+me';

  void _launchGoogleSearch() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void _launchMaps() {
    MapsLauncher.launchQuery('hospital near me');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: 32),
          // * Launch Map (refactor)
          Container(
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
                      'assets/image/map.jpg',
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
                              Icons.map,
                              color: Colors.white,
                              size: 32,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Locate Hospital',
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
                          '\nLocate the nearby hospitals using your default map application.\n\nDefaults to Google Maps.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      SizedBox(height: 32),

                      // * Action
                      Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            // minimumSize: Size(200, 100),
                          ),
                          icon: Icon(Icons.launch),
                          label: Text('Launch'),
                          onPressed: () {
                            _launchMaps();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 32),

          // * Launch Search (refactor)
          Container(
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
                      'assets/image/search.jpg',
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
                              Icons.map,
                              color: Colors.white,
                              size: 32,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Search Hospital',
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
                          '\nSearch hospitals near you using Google.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      SizedBox(height: 32),

                      // * Action
                      Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.white,
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            // minimumSize: Size(200, 100),
                          ),
                          icon: Icon(Icons.launch),
                          label: Text('Launch'),
                          onPressed: () {
                            _launchGoogleSearch();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
