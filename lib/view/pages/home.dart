import 'package:companera/services/authentication.dart';
import 'package:companera/view/pages/auth.dart';
import 'package:flutter/material.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            AuthService.signOut(context);
          },
            child: Text('${AuthService().signedInUser?.displayName}')),
      ),
    );
  }
}
