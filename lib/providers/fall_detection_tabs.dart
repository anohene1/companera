import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../model/fall_detection_tab.dart';

class FallDetectionTabs extends ChangeNotifier {
  List<FallDetectionTab> fallDetectionTabs = [
    FallDetectionTab(title: 'Today', isSelected: true),
    FallDetectionTab(title: 'This week'),
    FallDetectionTab(title: 'This month'),
  ];

  UnmodifiableListView<FallDetectionTab> get tabs {
    return UnmodifiableListView(fallDetectionTabs);
  }

  void setSelectStatus(FallDetectionTab tab, bool selected){
    tab.isSelected = selected;
    notifyListeners();
  }

  void deselectAllCategories(){
    fallDetectionTabs.forEach((element) {element.isSelected = false;});
    notifyListeners();
  }

  int get tabsCount {
    return fallDetectionTabs.length;
  }
}