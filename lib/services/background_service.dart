import 'dart:async';

import 'package:companera/services/fall_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';


class BackgroundService {
   Future<void> initializeBackgroundService() async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will executed when app is in foreground or background in separated isolate
        onStart: onStart,

        // auto start service
        autoStart: false,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: false,

        // this will executed when app is in foreground in separated isolate
        onForeground: onStart,

        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );
    // service.startService();
  }

  FutureOr<bool> onIosBackground(ServiceInstance serviceInstance) async {
    WidgetsFlutterBinding.ensureInitialized();
    print('FLUTTER BACKGROUND FETCH');
    return true;
  }




}

void onStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();


  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });


  // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {

    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Fall Detection Running",
        content: "Turn it off in app settings if you don't want it running.",
      );
    }


    //Detect falls
    FallDetector.detectFalls();

  });
}