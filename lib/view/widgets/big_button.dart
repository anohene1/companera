import 'package:flutter/material.dart';

import '../../constants/app-colors.dart';

class BigButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const BigButton({Key? key, required this.label, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: double.infinity,
        height: 70,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(color: AppColors.primaryBackgroundColor, borderRadius: BorderRadius.circular(10)),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(color: HexColor.fromHex("A06AFA"), shape: BoxShape.circle),
              child: Icon(icon, color: Colors.white, size: 20)),
          SizedBox(width: 10,),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text(label, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
          ])
        ]),
      ),
    );
  }
}