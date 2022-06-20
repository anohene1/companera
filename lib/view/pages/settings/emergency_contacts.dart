import 'package:companera/services/contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app-colors.dart';
import '../../widgets/dark_radial_background.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyContactsScreen> createState() => _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: Text('Emergency Contacts'),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ContactPicker.pickContact();
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
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
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text('Nobody\'s here :(', style: GoogleFonts.lato(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                  Text('Add people who should be contacted in case you fall (although we hope you don\'t)', style: TextStyle(fontSize: 18, color: HexColor.fromHex("666A7A")))
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
