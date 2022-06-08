import 'package:companera/providers/speech_settings.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  final FlutterTts flutterTts = FlutterTts();
  final SpeechSettings settings = SpeechSettings();

  Future speak(String text) async {
    await flutterTts.setSpeechRate(settings.speechRate);
    await flutterTts.setPitch(settings.speechPitch);
    await flutterTts.setVolume(settings.speechVolume);
    await flutterTts.setVoice({"name": "en-gb-x-gba-local", "locale": "en-GB"});
    await flutterTts.speak(text);
  }

  void stop() {
    flutterTts.stop();
  }
}