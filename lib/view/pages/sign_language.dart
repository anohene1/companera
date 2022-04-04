import 'package:flutter/material.dart';

class SignLanguageScreen extends StatefulWidget {
  const SignLanguageScreen({Key? key}) : super(key: key);

  @override
  State<SignLanguageScreen> createState() => _SignLanguageScreenState();
}

class _SignLanguageScreenState extends State<SignLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Sign Language'),
    );
  }
}