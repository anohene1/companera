import 'package:companera/view/widgets/monthly_fall_bar_chart.dart';
import 'package:flutter/material.dart';

class ThisMonth extends StatelessWidget {
  const ThisMonth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MonthlyFallChart(),
        ],
      ),
    );
  }
}