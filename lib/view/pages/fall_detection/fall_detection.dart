import 'package:companera/providers/fall_detection_tabs.dart';
import 'package:companera/view/pages/fall_detection/this_month.dart';
import 'package:companera/view/pages/fall_detection/this_week.dart';
import 'package:companera/view/pages/fall_detection/today.dart';
import 'package:companera/view/widgets/monthly_fall_bar_chart.dart';
import 'package:companera/view/widgets/tab_button.dart';
import 'package:companera/view/widgets/weekly_fall_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FallDetectionScreen extends StatefulWidget {
  const FallDetectionScreen({Key? key}) : super(key: key);

  @override
  State<FallDetectionScreen> createState() => _FallDetectionScreenState();
}

class _FallDetectionScreenState extends State<FallDetectionScreen> {


  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            height: 40,
            margin: EdgeInsets.only(bottom: 10),
            child: Consumer<FallDetectionTabs>(
              builder: (context, tabs, child) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tabs.tabsCount,
                  itemBuilder: (context, index) {
                    final tab = tabs.tabs[index];
                    return PrimaryTabButton(buttonText: tab.title, isSelected: tab.isSelected, onTap: () {
                      tabs.deselectAllCategories();
                      tabs.setSelectStatus(tab, true);
                      setState(() {
                        currentIndex = index;
                      });
                    },);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: [
                Today(),
                ThisWeek(),
                ThisMonth()
              ],
            )
          ),
        ],
      ),
    );
  }
}
