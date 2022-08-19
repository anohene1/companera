import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companera/services/db.dart';
import 'package:companera/utils/date_time_extension.dart';
import 'package:companera/utils/timestampFormatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../constants/app-colors.dart';
import '../../../model/fall.dart';

class Today extends StatefulWidget {
  Today({Key? key}) : super(key: key);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.6745, -1.5716),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(6.6745, -1.5716),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  DB database = DB();

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: database.streamFalls(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<Fall> fallsToday = snapshot.data!.docs
            .map((e) => Fall(
                latitude: e['latitude'],
                longitude: e['longitude'],
                timestamp: Timestamp.fromMillisecondsSinceEpoch(e['timestamp'])))
            .where((element) =>
                element.timestamp.toDate().isSameDate(DateTime.now()))
            .toList();

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
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
                Text(
                  'Oopsie...',
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Text('An error occurred: ${snapshot.error.toString()}',
                    style: TextStyle(
                        fontSize: 18, color: HexColor.fromHex("666A7A")))
              ],
            ),
          );
        }
        if (fallsToday.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No falls recorded!',
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'You are doing very well today, no falls have been detected.',
                style:
                    TextStyle(fontSize: 18, color: HexColor.fromHex("666A7A")),
              )
            ],
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                child: ListView.builder(
                  itemCount: fallsToday.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Fall ${index + 1}'),
                      subtitle: Text(TimestampFormatter.format(
                          fallsToday[index].timestamp.millisecondsSinceEpoch)),
                      onTap: () async {
                        launchUrlString('https://www.google.com/maps/search/?api=1&query=${fallsToday[index].latitude},${fallsToday[index].longitude}');
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 300,
                  width: 400,
                  child: GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: Today._kGooglePlex,
                    markers: fallsToday.map((fall) {
                      return Marker(
                          markerId: MarkerId(fall.timestamp.toString()),
                          icon: BitmapDescriptor.defaultMarker,
                          position: LatLng(fall.latitude, fall.longitude),
                          infoWindow: InfoWindow(
                              title: TimestampFormatter.format(
                                  fall.timestamp.millisecondsSinceEpoch)));
                    }).toSet(),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
