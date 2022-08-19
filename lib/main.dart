import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:companera/providers/emergency_contacts_provider.dart';
import 'package:companera/providers/fall_detection_tabs.dart';
import 'package:companera/providers/speech_settings.dart';
import 'package:companera/services/authentication.dart';
import 'package:companera/services/background_service.dart';
import 'package:companera/services/fall_detector.dart';
import 'package:companera/view/pages/auth.dart';
import 'package:companera/view/pages/home.dart';
import 'package:companera/view/pages/settings/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getSwitchValue();
  BackgroundService().initializeBackgroundService();
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'companera_channel_group',
            channelKey: 'companera_channel',
            channelName: 'Fall Detection Notifications',
            channelDescription: 'Notification channel for when falls are detected',
            defaultColor: Color(0xff246CFE),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupkey: 'companera_channel_group',
            channelGroupName: 'Companera group')
      ],
      debug: true
  );
  AwesomeNotifications().actionStream.listen((action) {
    if(action.buttonKeyPressed == "false"){
      print("False button is pressed.");
      FallDetector().cancelFallTimer();
    }else{
      print('notification was pressed'); //notification was pressed
    }
  });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<FallDetectionTabs>(create: (context) => FallDetectionTabs()),
      ChangeNotifierProvider<SpeechSettings>(create: (context) => SpeechSettings()),
      ChangeNotifierProvider<EmergencyContactsProvider>(create: (context) => EmergencyContactsProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Compañera',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColor: const Color(0xff246CFE),
        brightness: Brightness.dark,
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
      ),
      home: AuthService().signedInUser == null ? AuthScreen() : const HomeScreen(),
    );
  }
}

