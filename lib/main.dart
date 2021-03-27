import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import './theme/theme.dart';
import './theme/theme_service.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Health Card',
      theme: Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      themeMode: ThemeServie().getThemeMode(),
      home: DarkModeHome(),
    );
  }
}

// * Home screen with dark mode switch
class DarkModeHome extends StatefulWidget {
  DarkModeHome({Key key}) : super(key: key);

  @override
  _DarkModeHomeState createState() => _DarkModeHomeState();
}

class _DarkModeHomeState extends State<DarkModeHome> {
  bool value = ThemeServie().isSavedDarkMode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      //  * Appbar
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      appBar: AppBar(
        title: Text('Health App'),
        actions: [
          CupertinoSwitch(
              value: value,
              onChanged: (value) => setState(() {
                    this.value = value;
                    ThemeServie().changeThemeMode(value);
                  })),
        ],
      ),

      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      //  * Homepage -> List of modules
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    );
  }
}
