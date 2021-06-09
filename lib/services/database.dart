import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Testsammlung');

  Future updateUserData(String name, String email, String home) async {
    return await userCollection.doc(uid).set(
      {
        'Name': name,
        'Email': email,
        'Wohnort': home,
      },
    );
  }
}
