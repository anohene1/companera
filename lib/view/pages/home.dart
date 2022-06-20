import 'package:companera/services/authentication.dart';
import 'package:companera/view/pages/auth.dart';
import 'package:companera/view/pages/fall_detection/fall_detection.dart';
import 'package:companera/view/pages/settings/settings.dart';
import 'package:companera/view/pages/sign_language.dart';
import 'package:companera/view/pages/text_recoginition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../constants/app-colors.dart';
import '../widgets/dark_radial_background.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF1D192D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          // "Hello, \n${AuthService().signedInUser?.displayName}",
          "Hello, \nIsaac Anohene",
          style: GoogleFonts.raleway(
              // fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white),
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF1D192D),
        child: SafeArea(
          left: false,
          right: false,
          child: SalomonBottomBar(
            currentIndex: currentIndex,
            unselectedItemColor: Colors.white54,
            onTap: (index) {
              if (index == 3) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                return;
              }
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              SalomonBottomBarItem(icon: Icon(LineIcons.running), title: Text('Fall Detection')),
              SalomonBottomBarItem(icon: Icon(LineIcons.signLanguage), title: Text('Sign Language')),
              SalomonBottomBarItem(icon: Icon(LineIcons.bookOpen), title: Text('Read')),
              SalomonBottomBarItem(icon: Icon(LineIcons.cog), title: Text('Settings'),),
            ],
          ),
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              // height: double.infinity,
              // width: double.infinity,
              child: DarkRadialBackground(
                color: HexColor.fromHex("#181a1f"),
                position: "topLeft",
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 130),
              child: IndexedStack(
                index: currentIndex,
                children: [
                  FallDetectionScreen(),
                  SignLanguageScreen(),
                  TextRecognitionScreen(),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
