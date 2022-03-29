import 'package:companera/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app-colors.dart';

class CarouselItem extends StatelessWidget {
  final String title;
  final String caption;
  final String image;
  const CarouselItem({Key? key, required this.title, required this.caption, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            right: 0,
            top: 30,
            bottom: 20,
            child: Image.asset(image, width: Utils.screenWidth,)),
        Positioned(
          bottom: 0,
          left: 20,
          right: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white),
              ),
              Text(caption, style: GoogleFonts.montserrat(fontSize: 18, color: HexColor.fromHex("666A7A")),),
            ],
          ),
        )
      ],
    );
  }
}
