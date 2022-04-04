import 'package:companera/view/widgets/monthly_fall_bar_chart.dart';
import 'package:companera/view/widgets/weekly_fall_bar_chart.dart';
import 'package:flutter/material.dart';

class FallDetectionScreen extends StatefulWidget {
  const FallDetectionScreen({Key? key}) : super(key: key);

  @override
  State<FallDetectionScreen> createState() => _FallDetectionScreenState();
}

class _FallDetectionScreenState extends State<FallDetectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            WeeklyFallChart(),
            SizedBox(height: 20,),
            MonthlyFallChart(),
          ],
        ),
      ),
    );
  }
}
