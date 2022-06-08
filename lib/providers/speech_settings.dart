import 'package:flutter/material.dart';

class SpeechSettings extends ChangeNotifier {
  double rate = 0.5;
  double volume = 1;
  double pitch = 1;

  double get speechRate {
    return rate;
  }

  double get speechVolume {
    return volume;
  }

  double get speechPitch {
    return pitch;
  }

  void setSpeechRate(double newRate) {
    rate = newRate;
    notifyListeners();
  }

  void setSpeechVolume(double newVolume) {
    volume = newVolume;
    notifyListeners();
  }

  void setSpeechPitch(double newPitch) {
    pitch = newPitch;
    notifyListeners();
  }
}