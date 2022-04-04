import 'package:companera/constants/button_styles.dart';
import 'package:companera/view/pages/home.dart';
import 'package:companera/view/widgets/carousel_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app-colors.dart';
import '../../services/authentication.dart';
import '../../utils/utils.dart';
import '../widgets/dark_radial_background.dart';
import '../widgets/image_outlined_button.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 12 : 8.0,
      width: isActive ? 12 : 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Color(0xFF266FFE) : Color(0xFF666A7A),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(children: [
              Container(
                // height: double.infinity,
                // width: double.infinity,
                child: DarkRadialBackground(
                  color: HexColor.fromHex("#181a1f"),
                  position: "bottomRight",
                ),
              ),
              //Buttons positioned below
              Column(children: [
                Container(
                    height: Utils.screenHeight * .6,
                    child: SafeArea(
                      child: PageView(
                          physics: ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                          children: const <Widget>[
                            CarouselItem(
                                title: 'Detect Falls',
                                caption:
                                    'Automatically detect falls and alert your \nemergency contacts',
                                image: 'assets/new_fall.png'),
                            CarouselItem(
                                title: 'Translate \nSign Language',
                                caption:
                                    'Use camera to detect and interpret \nsign language',
                                image: 'assets/sign_language.png'),
                            CarouselItem(
                                title: 'Read Text \nFrom Images',
                                caption:
                                    "Can't read without your glasses? \nJust take a picture of the text, we'll read it for you!",
                                image: 'assets/read_text.png'),
                          ]),
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _buildPageIndicator(),
                        ),
                        SizedBox(height: 40),
                        Container(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context, builder: (context){
                                  return Container(
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                },
                                barrierDismissible: false
                                );
                                //TODO: Handle errors
                                AuthService.signInWithGoogle().then((value) =>
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()))
                                ).onError((error, stackTrace) async {
                                  Navigator.pop(context);
                                  print(error);
                                  await FlutterPlatformAlert.showAlert(windowTitle: 'Unable to sign in', text: 'Please check your internet connection and try again later');
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      HexColor.fromHex("246CFE")),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: BorderSide(
                                              color: HexColor.fromHex(
                                                  "246CFE"))))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/google_icon.png',
                                    height: 20,
                                  ),
                                  Text('   Continue with Google',
                                      style: GoogleFonts.lato(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyles.imageRounded,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/apple_icon.png',
                                    height: 20,
                                  ),
                                  Text('   Continue with Apple',
                                      style: GoogleFonts.lato(
                                          fontSize: 20, color: Colors.white)),
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                              'By continuing you agree Compañera\'s Terms of Services & Privacy Policy.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                  fontSize: 15,
                                  color: HexColor.fromHex("666A7A"))),
                        )
                      ]),
                    ),
                  ),
                ),
              ])
            ])));
  }
}
