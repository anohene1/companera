import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companera/model/fall.dart';
import 'package:companera/services/db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math';


class FallDetector {

  late Timer timer;

  void cancelFallTimer() {
    timer.cancel();
  }

  Future<void> detectFalls() async {

    await Firebase.initializeApp();
    DB database = DB();


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
                  showWhen: true,
                  id: 123,
                  channelKey: 'companera_channel', //set configuration wuth key "basic"
                  title: 'Looks like a fall has occurred.',
                  body: 'Click on False if this is not a real fall.',
                  // payload: {"name":"FlutterCampus"},
                  autoDismissible: true,
                ),

                actionButtons: [

                  NotificationActionButton(
                    key: "false",
                    label: "False",
                  )
                ]
            ).then((value) {
            timer = Timer(const Duration(seconds: 30), () {
              Fall fall = Fall(latitude: 3.2, longitude: 1.1, timestamp: Timestamp.now());
              AwesomeNotifications().dismiss(123);
              AwesomeNotifications().createNotification(
                content: NotificationContent( //
                  wakeUpScreen: true,
                  fullScreenIntent: true,
                  showWhen: true,
                  id: 124,
                  channelKey: 'companera_channel', //set configuration wuth key "basic"
                  title: 'Emergency Contacts notified',
                  body: 'We have notified your emergency contacts about this fall',
                  // payload: {"name":"FlutterCampus"},
                  autoDismissible: false,
                ),);
              database.addFall(fall);
            });
            });
          }
        });
        // If notification is not attended to or is confirmed, get location and send sms
      }
    });
  }


}