import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignInUI extends StatelessWidget {
  const SignInUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: true);

            if (provider.isSigningIn) {
              print('1 called');
              return buildLoading();
            } else if (snapshot.hasData) {
              print('2 called');
              return const LoggedInWidget();
            } else {
              print('3 called');
              return const SignUpWidget();
            }
          },
        ),
      ),
    );
  }

  // Loading animation
  Widget buildLoading() => const Center(child: CircularProgressIndicator());
}

/// * Provider
class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn = false;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  /// * Login Backend
  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      isSigningIn = false;
    }
  }

  /// * Logout Backend
  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

/// * Sign Up Widget
class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.black,
              primary: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            icon: const FaIcon(FontAwesomeIcons.google),
            label: const Text('Sign In With Google'),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.login();
            },
          ),
        ),
      ],
    );
  }
}

/// * Logged In Widget
class LoggedInWidget extends StatelessWidget {
  const LoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Column(
      children: [
        const Text('Logged In'),
        CircleAvatar(
          maxRadius: 30,
          backgroundImage: NetworkImage(user!.photoURL!),
        ),
        Text('Name: ${user.displayName}'),
        Text('Email: ${user.email}'),

        /// * Logout button
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            icon: const FaIcon(FontAwesomeIcons.signOutAlt),
            label: const Text('Logout'),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          ),
        ),
      ],
    );
  }
}
