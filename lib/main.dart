// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Pub Dev Imports
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_app/src/settings.dart';

// Flutter Components Imports for Navigation
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
      title: 'Digital Health Card',
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
  @override
  void initState() {
    super.initState();
    bool isNavHidden = ThemeServie().isStatusHidden();
    if (isNavHidden) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
  }

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
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Get.to(() => SettingsPage());
            },
            iconSize: 32,
          ),
          SizedBox(width: 20),
        ],
      ),

      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      //  * Homepage
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        children: [
          WelcomeCard(),
          Dashboard(),
        ],
      ), // Imported: ./src/dashboard
    );
  }
}
