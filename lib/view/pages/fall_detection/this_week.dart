import 'package:companera/view/widgets/weekly_fall_bar_chart.dart';
import 'package:flutter/material.dart';

class ThisWeek extends StatelessWidget {
  const ThisWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          WeeklyFallChart()
        ],
      ),
    );
  }
}