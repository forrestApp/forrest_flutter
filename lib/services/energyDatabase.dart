import 'package:cloud_firestore/cloud_firestore.dart';

class AddEnergyDatabaseService {
  final String uid;
  final String powerDate;
  final String heatingDate;

  AddEnergyDatabaseService({this.uid, this.powerDate, this.heatingDate});

  final CollectionReference userFoodCollection =
      FirebaseFirestore.instance.collection('Nutzerdaten');

  Future addNewPower(
      String typeOfPower, int amountOfPower, int emissions) async {
    return await userFoodCollection
        .doc(uid)
        .collection('NutzerTracking')
        .doc(powerDate)
        .set({
      'Stromart': typeOfPower,
      'Menge': amountOfPower,
      'Emissionen': emissions,
    });
  }

  Future addNewHeating(
      String typeOfHeating, int amountOfHeating, int emissions) async {
    return await userFoodCollection
        .doc(uid)
        .collection('NutzerTracking')
        .doc(heatingDate)
        .set({
      'Heizungsart': typeOfHeating,
      'Menge': amountOfHeating,
      'Emissionen': emissions,
    });
  }
}
