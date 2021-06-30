import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forrest_flutter/modules/firebaseUser.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Nutzerdaten');

  Future updateUserData(String name, String email, String home) async {
    return await userCollection.doc(uid).set(
      {
        'Name': name,
        'Email': email,
        'Wohnort': home,
      },
    );
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: (snapshot.data() as DocumentSnapshot)['Name'],
      email: (snapshot.data() as DocumentSnapshot)['Email'],
      home: (snapshot.data() as DocumentSnapshot)['Wohnort'],
      car: (snapshot.data() as DocumentSnapshot)['Auto'],
    );
  }

  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
