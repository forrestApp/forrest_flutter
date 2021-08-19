import 'package:cloud_firestore/cloud_firestore.dart';

class AddDailyTransportDatabaseService {
  final String uid;
  final String date;

  AddDailyTransportDatabaseService({this.uid, this.date});

  final CollectionReference userFoodCollection =
      FirebaseFirestore.instance.collection('Nutzerdaten');

  Future addNewDailyTransport(String transportCategory, int emissions) async {
    return await userFoodCollection.doc(uid).collection(date).add({
      'Name': transportCategory,
      'Emissionen': emissions,
    });
  }
}
