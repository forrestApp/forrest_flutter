import 'package:cloud_firestore/cloud_firestore.dart';

class AddDailyConsumptionDatabaseService {
  final String uid;
  final String date;

  AddDailyConsumptionDatabaseService({this.uid, this.date});

  final CollectionReference userFoodCollection =
      FirebaseFirestore.instance.collection('Nutzerdaten');

  Future addNewDailyConsumption(String name, int emissions) async {
    return await userFoodCollection.doc(uid).collection(date).add({
      'Name': name,
      'Emissionen': emissions,
    });
  }
}
