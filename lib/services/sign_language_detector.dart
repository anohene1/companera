import 'package:tflite/tflite.dart';

class SignLanguageDetector {
  void loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model/model.tflite', labels: 'assets/model/labels.txt');
  }
}
