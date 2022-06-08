import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  final FlutterTts flutterTts = FlutterTts();

  Future speak(String text) async {
    await flutterTts.setVoice({"name": "en-gb-x-gba-local", "locale": "en-GB"});
    await flutterTts.speak(text);
  }
}