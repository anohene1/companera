import 'package:companera/model/emergency_contact.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class ContactPicker {
  static Future<EmergencyContact> pickContact() async {
    PhoneContact contact = await FlutterContactPicker.pickPhoneContact();

    return EmergencyContact(name: contact.fullName.toString(), number: contact.phoneNumber!.number!.replaceAll(' ', ''));
  }

}