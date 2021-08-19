import 'package:cloud_firestore/cloud_firestore.dart';

class AddFoodDatabaseService {
  final String foodCategory;

  AddFoodDatabaseService({this.foodCategory});

  final CollectionReference foodCollection =
      FirebaseFirestore.instance.collection('Ernährung');

  Future addNewFood(String name, int emissions, List siegel, String origin,
      double animalProduct, int packaging) async {
    return await foodCollection.add({
      'Name': name,
      'Emissionen': emissions,
      'Siegel': siegel,
      'Herkunft': origin,
      'Tierisches Produkt': animalProduct,
      'Verpackung': packaging,
    });
  }

  Future getFoodCollection() async {
    List foodCollectionList = [];
    try {
      await foodCollection.get().then((QuerySnapshot querySnapshot) {
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
