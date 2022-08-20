import 'package:companera/utils/date_time_extension.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../model/fall.dart';

class MonthlyFallChart extends StatelessWidget {
  final List<Fall> falls;
  MonthlyFallChart({Key? key, required this.falls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      decoration: BoxDecoration(
          color: Color.fromRGBO(98, 99, 102, 1).withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Falls detected this month', style: TextStyle(
                  color: Color(0xff7589a2),
                  fontSize: 16,
                )),
                IconButton(onPressed: (){}, icon: Icon(Icons.adaptive.share, color: Colors.white,))
              ],
            ),
          ),
          Expanded(
            child: BarChart(
              BarChartData(
                barTouchData: barTouchData,
                titlesData: titlesData,
                borderData: borderData,
                barGroups: barGroups(falls),
                gridData: FlGridData(show: false),
                alignment: BarChartAlignment.spaceAround,
                maxY: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: const EdgeInsets.all(0),
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Week 1';
        break;
      case 1:
        text = 'Week 2';
        break;
      case 2:
        text = 'Week 3';
        break;
      case 3:
        text = 'Week 4';
        break;
      case 4:
        text = 'Thu';
        break;
      case 5:
        text = 'Fri';
        break;
      case 6:
        text = 'Sat';
        break;
      default:
        text = '';
        break;
    }
    return Center(child: Text(text, style: style));
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  final _barsGradient = const LinearGradient(
    colors: [
      Color(0xFFA06AFA),
      Color(0xFFFAA3FF),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> barGroups(List<Fall> falls) {
    int week1 = falls.where((element) => element.timestamp.toDate().isFirstWeek()).length;
    int week2 = falls.where((element) => element.timestamp.toDate().isSecondWeek()).length;
    int week3 = falls.where((element) => element.timestamp.toDate().isThirdWeek()).length;
    int week4 = falls.where((element) => element.timestamp.toDate().isLastWeek()).length;
    return [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: double.parse(week1.toString()),
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: double.parse(week2.toString()),
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: double.parse(week3.toString()),
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: double.parse(week4.toString()),
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    ),
    // BarChartGroupData(
    //   x: 4,
    //   barRods: [
    //     BarChartRodData(
    //       toY: 13,
    //       gradient: _barsGradient,
    //     )
    //   ],
    //   showingTooltipIndicators: [0],
    // ),
    // BarChartGroupData(
    //   x: 5,
    //   barRods: [
    //     BarChartRodData(
    //       toY: 10,
    //       gradient: _barsGradient,
    //     )
    //   ],
    //   showingTooltipIndicators: [0],
    // ),
    // BarChartGroupData(
    //   x: 6,
    //   barRods: [
    //     BarChartRodData(
    //       toY: 4,
    //       gradient: _barsGradient,
    //     )
    //   ],
    //   showingTooltipIndicators: [0],
    // ),
  ];
  }
}
//
// class BarChartSample3 extends StatefulWidget {
//   const BarChartSample3({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => BarChartSample3State();
// }
//
// class BarChartSample3State extends State<BarChartSample3> {
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.7,
//       child: Card(
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//         color: const Color(0xff2c4260),
//         child: const MonthlyFallChart(),
//       ),
//     );
//   }
// }