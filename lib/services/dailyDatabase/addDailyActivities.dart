import 'package:cloud_firestore/cloud_firestore.dart';

class AddDailyActivitiesDatabaseService {
  final String uid;
  final String date;

  AddDailyActivitiesDatabaseService({this.uid, this.date});

  final CollectionReference userFoodCollection =
      FirebaseFirestore.instance.collection('Nutzerdaten');

  Future addNewDailyActivities(
      String name, int emissions, String origin) async {
    return await userFoodCollection
        .doc(uid)
        .collection('NutzerTracking')
        .doc('Aktivitäten')
        .collection(date)
        .add({
      'Name': name,
      'Emissionen': emissions,
    });
  }

  Future getCurrentActivityEmission() async {
    List foodCollectionList = [];
    try {
      await userFoodCollection.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          foodCollectionList.add(element.data());
        });
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
