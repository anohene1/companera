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
        const SizedBox(height: 10,),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.primaryBackgroundColor),
            child: Column(
              children: children,
            ),
          ),
        ),
        const SizedBox(height: 25,)
      ],
    );
  }
}
