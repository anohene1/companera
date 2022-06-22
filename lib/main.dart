import 'package:companera/providers/fall_detection_tabs.dart';
import 'package:companera/providers/speech_settings.dart';
import 'package:companera/services/authentication.dart';
import 'package:companera/services/fall_detector.dart';
import 'package:companera/view/pages/auth.dart';
import 'package:companera/view/pages/home.dart';
import 'package:companera/view/pages/settings/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FallDetector().initializeBackgroundService();
  getSwitchValue();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<FallDetectionTabs>(create: (context) => FallDetectionTabs()),
      ChangeNotifierProvider<SpeechSettings>(create: (context) => SpeechSettings()),
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

