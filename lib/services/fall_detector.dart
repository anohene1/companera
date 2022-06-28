import 'package:awesome_notifications/awesome_notifications.dart';
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
        AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
          if (!isAllowed) {

            AwesomeNotifications().requestPermissionToSendNotifications();
          } else {
            AwesomeNotifications().createNotification(
                content: NotificationContent( //
                  wakeUpScreen: true,
                  fullScreenIntent: true,
                  showWhen: true,// simgple notification
                  id: 123,
                  channelKey: 'companera_channel', //set configuration wuth key "basic"
                  title: 'Looks like a fall has occurred.',
                  body: 'Click on False if this is not a real fall.',
                  // payload: {"name":"FlutterCampus"},
                  autoDismissible: false,
                ),

                actionButtons: [
                  NotificationActionButton(
                    key: "true",
                    label: "True",
                  ),

                  NotificationActionButton(
                    key: "false",
                    label: "False",
                  )
                ]
            );
          }
        });
        // If notification is not attended to or is confirmed, get location and send sms
      }
    });
  }
}