// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Pub Dev Imports
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Flutter Components Imports
import './src/dashboard.dart';

// Dark mode imports
import './theme/theme.dart';
import './theme/theme_service.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * main()
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * InitApp
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
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

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Home screen with dark mode switch
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
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
      //  * Appbar + Dark mode switch
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Health App',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
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
      //  * Homepage
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      body: Dashboard(), // Imported: ./src/dashboard
    );
  }
}
