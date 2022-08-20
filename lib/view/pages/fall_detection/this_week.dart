import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companera/utils/date_time_extension.dart';
import 'package:companera/view/widgets/weekly_fall_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../constants/app-colors.dart';
import '../../../model/fall.dart';
import '../../../services/db.dart';
import '../../../utils/timestampFormatter.dart';

class ThisWeek extends StatelessWidget {
   ThisWeek({Key? key}) : super(key: key);

  Completer<GoogleMapController> _controller = Completer();
   DB database = DB();


   static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.6745, -1.5716),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(6.6745, -1.5716),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  String? _mapStyle;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: database.streamFalls(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<Fall> fallsThisWeek = snapshot.data!.docs
            .map((e) => Fall(
            latitude: e['latitude'],
            longitude: e['longitude'],
            timestamp: Timestamp.fromMillisecondsSinceEpoch(e['timestamp'])))
            .where((element) =>
            element.timestamp.toDate().isSameWeek(DateTime.now()))
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
        if (fallsThisWeek.isEmpty) {
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
                'You are doing very well this week, no falls have been detected.',
                style:
                TextStyle(fontSize: 18, color: HexColor.fromHex("666A7A")),
              )
            ],
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              WeeklyFallChart(falls: fallsThisWeek,),
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
                    initialCameraPosition: _kGooglePlex,
                    markers: fallsThisWeek.map((fall) {
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