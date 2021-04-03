// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Dark mode imports
import '../theme/theme_service.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = ThemeServie().isSavedDarkMode();
  bool isStatusHidden = ThemeServie().isStatusHidden();
  bool isDoctor = false; // TODO: implement global variable

  String aboutUs =
      'We aim to create universal health cards powered by a universal healthcare database to simplify the process of booking appointments, noting patient\'s symptoms and diagnosis, and prescription.\n\nGroup members\n1MS18EE002 - Abhijit Sahoo\n1MS18EE003 - Abhishek Choudhary\n1MS18EE009 - Amogh Mishra\n1MS18EE015 - Dhruv Kanthaliya\n\nThis app was made as a part of Semester VI Mini-Project showcase at MS Ramaiah Institute of Technology.\n\n';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings and About'),
        toolbarHeight: 72,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Text(
            'UI Settings',
            style: TextStyle(fontSize: 20),
          ),
          Divider(thickness: 2),
          ListView(
            shrinkWrap: true,
            children: [
              // * Dark Mode Toggle
              ListTile(
                leading: Icon(Icons.color_lens_sharp),
                title: Text('Dark Mode'),
                subtitle: Text('Enable dark mode'),
                trailing: CupertinoSwitch(
                  value: isDarkMode,
                  onChanged: (isDarkMode) => setState(
                    () {
                      this.isDarkMode = isDarkMode;
                      ThemeServie().changeThemeMode(isDarkMode);
                    },
                  ),
                ),
              ),
              // * Status Bar Hide Toggle
              ListTile(
                leading: Icon(Icons.padding),
                title: Text('Hide Status Bar'),
                subtitle: Text('Go fullscreen'),
                trailing: CupertinoSwitch(
                  value: isStatusHidden,
                  onChanged: (isStatusHidden) => setState(
                    () {
                      this.isStatusHidden = isStatusHidden;
                      if (isStatusHidden) {
                        SystemChrome.setEnabledSystemUIOverlays([]);
                      } else {
                        SystemChrome.setEnabledSystemUIOverlays(
                            SystemUiOverlay.values);
                      }
                      ThemeServie().saveStatusBarMode(isStatusHidden);
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 32),
          Text(
            'User Settings',
            style: TextStyle(fontSize: 20),
          ),
          Divider(thickness: 2),
          Text(
            'This data will appear in prescription cards and health notes to indicate which person created them.',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
          ),

          // * Name
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
              hintText: 'First Last',
            ),
          ),

          // * Orgnazitaion
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Orgnization',
              hintText: 'ABC Hospital | Self',
            ),
          ),

          // * Bool Medical Professional
          SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.medical_services_outlined),
            title: Text('Medical Professional'),
            subtitle: Text('Are you a medical professional'),
            trailing: CupertinoSwitch(
              value: isDoctor,
              onChanged: (isDoctor) => setState(
                () {
                  this.isDoctor = isDoctor;
                },
              ),
            ),
          ),

          // * About Section
          SizedBox(height: 32),
          Text(
            'About',
            style: TextStyle(fontSize: 20),
          ),
          Divider(thickness: 2),
          Text(
            aboutUs,
            style: TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
