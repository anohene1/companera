import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app-colors.dart';

class PrimaryTabButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final bool isSelected;
  const PrimaryTabButton(
      {Key? key, required this.onTap, required this.buttonText, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
              backgroundColor: isSelected
                  ? MaterialStateProperty.all<Color>(HexColor.fromHex("246CFE"))
                  : MaterialStateProperty.all<Color>(HexColor.fromHex("181A1F")),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: isSelected
                      ? BorderSide(color: HexColor.fromHex("246CFE"))
                      : BorderSide(color: HexColor.fromHex("181A1F"))))),
          child: Text(buttonText, style: GoogleFonts.lato(fontSize: 16, color: Colors.white)))
    );
  }
}