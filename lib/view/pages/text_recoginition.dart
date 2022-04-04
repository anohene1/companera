import 'package:flutter/material.dart';

class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({Key? key}) : super(key: key);

  @override
  State<TextRecognitionScreen> createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Text Recognition'),
    );
  }
}