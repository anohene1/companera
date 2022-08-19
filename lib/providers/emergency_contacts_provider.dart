import 'dart:collection';

import 'package:flutter/material.dart';

import '../model/emergency_contact.dart';

class EmergencyContactsProvider extends ChangeNotifier {
  List<EmergencyContact> contacts = [];

  UnmodifiableListView<EmergencyContact> get emergencyContacts {
    return UnmodifiableListView(contacts);
  }

  void setContacts(List<EmergencyContact> list) {
    contacts = list;
    notifyListeners();
  }
}