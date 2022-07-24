import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companera/model/emergency_contact.dart';
import 'package:companera/model/user.dart';
import 'package:companera/services/authentication.dart';

import '../model/fall.dart';

class DB {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final signedInUser = AuthService().signedInUser;

  Future<void> addUser(User user) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(user.uid)
        .set({
          'name': user.name,
          'email': user.email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addEmergencyContact(EmergencyContact contact) {
    return users
        .doc(signedInUser?.uid)
        .collection('emergency_contacts')
        .add({'name': contact.name, 'number': contact.number})
        .then((value) => print('contact added'))
        .catchError(
            (error) => print('failed to add emergency contact: $error'));
  }

  Stream<QuerySnapshot> emergencyContactsStream() {
    return users.doc(signedInUser?.uid).collection('emergency_contacts').orderBy('name').snapshots();
  }

  Future<void> deleteEmergencyContact(String id) {
    return users.doc(signedInUser?.uid).collection('emergency_contacts').doc(id).delete().then((value) => print('contact deleted'));
  }

  Future<void> addFall(Fall fall) {
    return users
        .doc(signedInUser?.uid)
        .collection('falls')
        .add({'latitude': fall.latitude, 'longitude': fall.longitude, 'timestamp': fall.timestamp.millisecondsSinceEpoch})
        .then((value) => print('fall added'))
        .catchError(
            (error) => print('failed to add fall: $error'));
  }

  Stream<QuerySnapshot> streamFalls() {
    return users.doc(signedInUser?.uid).collection('falls').orderBy('timestamp').snapshots();
  }
}
