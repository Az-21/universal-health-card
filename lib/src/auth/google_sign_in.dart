import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  late GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return; // do nothing and go back
    _user = googleUser; // assign google user to local user

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }
}
