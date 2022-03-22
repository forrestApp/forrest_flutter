import 'package:cloud_firestore/cloud_firestore.dart';

class AddDailyTransportDatabaseService {
  final String uid;
  final String date;

  AddDailyTransportDatabaseService({this.uid, this.date});

  final CollectionReference userFoodCollection =
      FirebaseFirestore.instance.collection('Nutzerdaten');

  Future addNewDailyTransport(
      String transportCategory, int transportDistance, int emissions) async {
    return await userFoodCollection
        .doc(uid)
        .collection('NutzerTracking')
        .doc('Mobilität')
        .collection(date)
        .add({
      'Name': transportCategory,
      'Distanz': transportDistance,
      'Emissionen': emissions,
    });
  }

  /*Future getDailyTransportExpandedValue(List todaysListedTransports) async {
    return await userFoodCollection
        .doc(uid)
        .collection('NutzerTracking')
        .doc('Mobilität')
        .collection(date)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        todaysListedTransports = todaysListedTransports + doc['Name'];
        print(doc['Name']);
      });
    });
  }*/
}
