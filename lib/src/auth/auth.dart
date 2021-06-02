import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:health_app/src/auth/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthUI extends StatefulWidget {
  const AuthUI({Key? key}) : super(key: key);

  @override
  _AuthUIState createState() => _AuthUIState();
}

class _AuthUIState extends State<AuthUI> {
  // * Shared prefs
  final _getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Universal Health Card', style: TextStyle(fontSize: 32)),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    onPrimary: Colors.black,
                    primary: Colors.white,
                    elevation: 10,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15)),
                icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                label: const Text('Login Using Google'),
                onPressed: () {
                  // * Google sign in
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();

                  // * Set orgnization and doctor status to default
                  if (_getStorage.read('orgnization') == null) {
                    _getStorage.write('orgnization', 'Self');
                  }
                  if (_getStorage.read('isDoc') == null) {
                    _getStorage.write('isDoc', false);
                  }
                  if (_getStorage.read('localCards') == null) {
                    _getStorage.write('localCards', [
                      'Abhijit | xxxx xxxx 0002',
                      'Abhishek | xxxx xxxx 0003',
                      'Amogh | xxxx xxxx 0009',
                      'Dhruv | xxxx xxxx 0015',
                    ]);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
