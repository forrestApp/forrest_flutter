import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final int currentYear;

  DatabaseService({this.uid, this.currentYear});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Nutzerdaten');

  Future updateUserData(String name, String email, String home,
      String profilePicture, String car, String bike) async {
    return await userCollection.doc(uid).set(
      {
        'Name': name,
        'Email': email,
        'Wohnort': home,
        'Profilbild': profilePicture,
        'Auto': car,
        'Motorrad': bike,
      },
    );
  }

  Future initializePowerData(
      String typeOfPower, int amoutOfPower, int emissionsOfPower) async {
    return await userCollection
        .doc(uid)
        .collection('NutzerTracking')
        .doc('Strom $currentYear')
        .set(
      {
        'Stromart': typeOfPower,
        'Menge': amoutOfPower,
        'Emissionen': emissionsOfPower,
      },
    );
  }

  Future initializeHeatingData(String typeOfHeating) async {
    return await userCollection
        .doc(uid)
        .collection('NutzerTracking')
        .doc('Wärme $currentYear')
        .set(
      {
        'Heizungsart': typeOfHeating,
      },
    );
  }

  Stream getDailyEmissions() {
    return userCollection.doc(uid).collection('NutzerTracking').snapshots();
  }
}
