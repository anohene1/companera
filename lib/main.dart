import 'package:companera/providers/fall_detection_tabs.dart';
import 'package:companera/services/authentication.dart';
import 'package:companera/view/pages/auth.dart';
import 'package:companera/view/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<FallDetectionTabs>(create: (context) => FallDetectionTabs())
    ],
    child: MyApp(),
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

      ),
      home: AuthService().signedInUser == null ? AuthScreen() : HomeScreen(),
    );
  }
}

