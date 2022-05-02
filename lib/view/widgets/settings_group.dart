import 'package:flutter/material.dart';

import '../../constants/app-colors.dart';

class SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const SettingsGroup({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.primaryBackgroundColor),
      child: Column(
        children: children,
      ),
    );
  }
}
