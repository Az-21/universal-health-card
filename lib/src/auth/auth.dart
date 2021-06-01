import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_app/src/auth/google_sign_in.dart';
import 'package:provider/provider.dart';

class AuthUI extends StatelessWidget {
  const AuthUI({Key? key}) : super(key: key);

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
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googleLogin();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
