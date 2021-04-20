// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Imports
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Pub Dev Imports
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_app/src/auth/auth.dart';
import 'package:health_app/src/settings.dart';
import 'package:firebase_core/firebase_core.dart';

// Flutter Components Imports for Navigation
import './src/dashboard.dart';

// Dark mode imports
import './theme/theme.dart';
import './theme/theme_service.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * main()
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// ignore: avoid_void_async
Future main() async {
  // Provider + Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Shared prefs
  await GetStorage.init();

  // Run main
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
      home: const DarkModeHome(),
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  * Home screen with dark mode switch
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class DarkModeHome extends StatefulWidget {
  const DarkModeHome({Key? key}) : super(key: key);

  @override
  _DarkModeHomeState createState() => _DarkModeHomeState();
}

class _DarkModeHomeState extends State<DarkModeHome> {
  @override
  void initState() {
    super.initState();
    final bool isNavHidden = ThemeServie().isStatusHidden();
    if (isNavHidden) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const SettingsPage());
        },
        label: const Text('Settings'),
        icon: const Icon(Icons.settings),
        foregroundColor: Colors.white,
        backgroundColor: CupertinoColors.systemGreen,
      ),

      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      //  * Homepage
      // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
      body: const HomeUI(),
    );
  }
}
