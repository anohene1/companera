import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';


class FallDetector {
  static void detectFalls() {
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {
      double ax, ay, az;
      ax = event.x;
      ay = event.y;
      az = event.z;

      double smv = sqrt(pow(ax, 2) + pow(ay, 2) + pow(az, 2));

      double? vector = double.tryParse(smv.toStringAsFixed(2));

      // print('!!!!!!!!!!!!!!!!!!!! $vector');

      if (vector! > 0.3 && vector < 0.5) {
        print('!!!!!!!!!!!!!!!!!!! Possible fall detected');


        // Show notification
        // If notification is not attended to or is confirmed, get location and send sms
      }
    });
  }
}