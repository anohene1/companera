import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/pages/auth.dart';

class AuthService {
  User? signedInUser = FirebaseAuth.instance.currentUser;

  static Future<void> signOut(BuildContext context) async {
    final response = await FlutterPlatformAlert.showAlert(windowTitle: 'Log Out', text: 'Are you sure you want to log out?', alertStyle: AlertButtonStyle.yesNo);

    if (response == AlertButton.yesButton) {
      FirebaseAuth.instance.signOut().then((value) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => AuthScreen()),
                (Route<dynamic> route) => false);
      });
    }

  }

  static Future<void> deleteAccount(BuildContext context) async {
    final response = await FlutterPlatformAlert.showAlert(
        windowTitle: 'Delete Account',
        text:
            'By clicking on \'Yes\', your account and it\'s associated data will be deleted permanently and cannot be recovered.',
        alertStyle: AlertButtonStyle.yesNo);

    if (response == AlertButton.yesButton) {
      //TODO delete account
      print('Delete account confirmed');
    }
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
