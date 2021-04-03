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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings and About'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            )
          ],
        ),
      ),
    );
  }
}
