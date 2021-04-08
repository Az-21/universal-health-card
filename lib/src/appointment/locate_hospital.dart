// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:getwidget/getwidget.dart';
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
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            // * Top padding
            SizedBox(height: 100),

            // * Launch Map
            GestureDetector(
              onTap: () {
                _launchMaps();
              },
              child: GFCard(
                elevation: 10,
                boxFit: BoxFit.cover,
                imageOverlay: AssetImage('assets/image/map.jpg'),
                color: Colors.green,
                title: GFListTile(
                  title: GFTypography(
                    text: 'Locate Hospital',
                    showDivider: false,
                    textColor: Colors.white,
                    type: GFTypographyType.typo3,
                    icon: Icon(
                      Icons.map_sharp,
                      color: Colors.white,
                      size: 32,
                    ),
                    dividerColor: Colors.white,
                    dividerWidth: 100,
                  ),
                  subtitle: GFTypography(
                    text:
                        '\nLocate the nearby hospitals using your default map application.\n\nDefaults to Google Maps.',
                    textColor: Colors.white,
                    type: GFTypographyType.typo6,
                    showDivider: false,
                  ),
                ),
                buttonBar: GFButtonBar(
                  children: <Widget>[
                    GFButton(
                      text: "Launch",
                      size: GFSize.LARGE,
                      elevation: 5,
                      color: Colors.green,
                      splashColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      icon: Icon(
                        Icons.launch,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _launchMaps();
                      },
                    ),
                  ],
                ),
              ),
            ),

            // * Launch search
            GestureDetector(
              onTap: () {
                _launchGoogleSearch();
              },
              child: GFCard(
                elevation: 10,
                boxFit: BoxFit.cover,
                imageOverlay: AssetImage('assets/image/search.jpg'),
                color: Colors.green,
                title: GFListTile(
                  title: GFTypography(
                    text: 'Search Hospital',
                    showDivider: false,
                    textColor: Colors.white,
                    type: GFTypographyType.typo3,
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 32,
                    ),
                    dividerColor: Colors.white,
                    dividerWidth: 100,
                  ),
                  subtitle: GFTypography(
                    text: '\nSearch hospitals near you using Google.',
                    textColor: Colors.white,
                    type: GFTypographyType.typo6,
                    showDivider: false,
                  ),
                ),
                buttonBar: GFButtonBar(
                  children: <Widget>[
                    GFButton(
                      text: "Launch",
                      size: GFSize.LARGE,
                      elevation: 5,
                      color: Colors.green,
                      splashColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      icon: Icon(
                        Icons.launch,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _launchGoogleSearch();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
