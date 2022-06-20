import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class ContactPicker {
  static void pickContact() async {
    PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
  }
}