import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;


import 'package:companera/view/widgets/monthly_fall_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ThisMonth extends StatelessWidget {
  ThisMonth({Key? key}) : super(key: key);

  Completer<GoogleMapController> _controller = Completer();

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
    return SingleChildScrollView(
      child: Column(
        children: [
          MonthlyFallChart(),
          SizedBox(height: 20,),
          ClipRRect(
          borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 300,
              width: 400,
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}