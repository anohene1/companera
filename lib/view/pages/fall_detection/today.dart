import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app-colors.dart';

class Today extends StatelessWidget {
  const Today({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('No falls recorded!', style: GoogleFonts.lato(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
        Text('You are doing very well today, no falls have been detected.', style: GoogleFonts.montserrat(fontSize: 18, color: HexColor.fromHex("666A7A")),)
      ],
    );
  }
}
