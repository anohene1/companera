import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companera/model/user.dart';


class DB {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(User user) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
      'name': user.name,
      'email': user.email,
      'uid': user.uid
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

}

