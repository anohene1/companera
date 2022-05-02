import 'package:flutter/material.dart';

import '../../constants/app-colors.dart';

class SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  final String heading;
  const SettingsGroup({Key? key, required this.children, required this.heading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            color: HexColor.fromHex("666A7A"),
          ),
        ),
        SizedBox(height: 10,),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primaryBackgroundColor),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
