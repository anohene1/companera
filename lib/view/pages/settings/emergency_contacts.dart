import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companera/services/contact_picker.dart';
import 'package:companera/services/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../../../constants/app-colors.dart';
import '../../widgets/dark_radial_background.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({Key? key}) : super(key: key);

  @override
  State<EmergencyContactsScreen> createState() => _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {

  DB database = DB();

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
        onPressed: () async {
          final pickedContact = await ContactPicker.pickContact();
          database.addEmergencyContact(pickedContact);
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
              child: StreamBuilder<QuerySnapshot>(
                stream: database.emergencyContactsStream(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('An error occured');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Nobody\'s here :(', style: GoogleFonts.lato(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                        Text('Add people who should be contacted in case you fall (although we hope you don\'t)', style: TextStyle(fontSize: 18, color: HexColor.fromHex("666A7A")))
                      ],
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return Slidable(
                        key: ValueKey(document.id),
                        endActionPane: ActionPane(
                          dismissible: DismissiblePane(onDismissed: () {
                            database.deleteEmergencyContact(document.id);
                          }),
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                database.deleteEmergencyContact(document.id);
                              },
                              icon: LineIcons.trash,
                              label: 'Delete',
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            )
                          ],

                        ),
                          child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['number']),
                      ));
                    }).toList()
                  );
                },
              )
            )
          ],
        ),
      )
    );
  }
}
