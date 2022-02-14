import 'package:cloud_firestore/cloud_firestore.dart';

class AddDailyFoodDatabaseService {
  final String uid;
  final String date;

  AddDailyFoodDatabaseService({this.uid, this.date});

  final CollectionReference userFoodCollection =
      FirebaseFirestore.instance.collection('Nutzerdaten');

  Future addNewDailyFood(String name, int emissions, String origin) async {
    return await userFoodCollection
        .doc(uid)
        .collection('NutzerTracking')
        .doc('Ernährung')
        .collection(date)
        .add({
      'Name': name,
      'Emissionen': emissions,
    });
  }
}
