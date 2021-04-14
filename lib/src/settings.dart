// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Dark mode imports
import '../theme/theme_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
        title: const Text('Settings and About'),
        toolbarHeight: 72,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          const Text(
            'UI Settings',
            style: TextStyle(fontSize: 20),
          ),
          const Divider(thickness: 2),
          ListView(
            shrinkWrap: true,
            children: [
              // * Dark Mode Toggle
              ListTile(
                leading: const Icon(Icons.color_lens_sharp),
                title: const Text('Dark Mode'),
                subtitle: const Text('Enable dark mode'),
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
                leading: const Icon(Icons.padding),
                title: const Text('Hide Status Bar'),
                subtitle: const Text('Go fullscreen'),
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
          const SizedBox(height: 32),
          const Text(
            'User Settings',
            style: TextStyle(fontSize: 20),
          ),
          const Divider(thickness: 2),
          const Text(
            'This data will appear in prescription cards and health notes to indicate which person created them.',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
          ),

          // * Name
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
              hintText: 'First Last',
            ),
          ),

          // * Orgnazitaion
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Orgnization',
              hintText: 'ABC Hospital | Self',
            ),
          ),

          // * Bool Medical Professional
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.medical_services_outlined),
            title: const Text('Medical Professional'),
            subtitle: const Text('Are you a medical professional'),
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
          const SizedBox(height: 32),
          const Text(
            'About',
            style: TextStyle(fontSize: 20),
          ),
          const Divider(thickness: 2),
          Text(
            aboutUs,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
