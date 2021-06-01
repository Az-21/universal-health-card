import 'package:flutter/material.dart';
import 'package:health_app/main.dart';
import 'package:health_app/src/auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text(
                        'Something went wrong. Please check your connection'));
              } else if (snapshot.hasData) {
                return const DarkModeHome();
              } else {
                return const AuthUI();
              }
            }));
  }
}
