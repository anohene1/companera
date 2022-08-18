import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companera/services/db.dart';
import 'package:companera/utils/timestampFormatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app-colors.dart';

class Today extends StatelessWidget {
  Today({Key? key}) : super(key: key);

  DB database = DB();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: database.streamFalls(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:
            CircularProgressIndicator(color: Theme.of(context).primaryColor,),
          );
        }
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Oopsie...', style: GoogleFonts.lato(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                Text('An error occurred: ${snapshot.error.toString()}', style: TextStyle(fontSize: 18, color: HexColor.fromHex("666A7A")))
              ],
            ),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('No falls recorded!', style: GoogleFonts.lato(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
              Text('You are doing very well today, no falls have been detected.', style: TextStyle(fontSize: 18, color: HexColor.fromHex("666A7A")),)
            ],
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final list = snapshot.data!.docs;
            DocumentSnapshot document = list[index];
            final data = document.data()! as Map<String, dynamic>;

            return ListTile(
              title: Text('Fall $index'),
              subtitle: Text(TimestampFormatter.format(data['timestamp'])),
            );
          },
        );
    },
    );
  }
}
