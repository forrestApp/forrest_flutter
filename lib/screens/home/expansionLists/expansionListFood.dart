import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forrest_flutter/screens/home/newElement/newFood.dart';
import 'package:forrest_flutter/services/dailyDatabase/addDailyFood.dart';
import 'package:intl/intl.dart';

final CollectionReference foodCollection =
    FirebaseFirestore.instance.collection('Ernährung');

final selectedFood = TextEditingController();
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;

class ExpansionListFood extends StatefulWidget {
  @override
  _ExpansionListFoodState createState() => _ExpansionListFoodState();
}

class _ExpansionListFoodState extends State<ExpansionListFood> {
  String listedFood = 'Du hast einen Apfel gekauft';

  List<Item> _data = [
    Item(
      icon: Icons.lunch_dining_outlined,
      headerValue: 'Lebensmittel',
      expandedValue: 'Du hast einen Apfel gekauft',
    ),
  ];

  String newFood;
  String categoryOfNewFood;
  String nameOfNewFood;
  int emissionsOfNewFood;
  String originOfNewFood;

  String todaysDate = DateFormat.yMMMd().format(DateTime.now());

  void _showAddFood() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            height: 600,
            child: Column(
              children: [
                Text(
                  'Füge hier ein neues Lebensmittel ein:',
                  style: TextStyle(
                    fontFamily: 'GloriaHalleluja',
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                DropDownField(
                  controller: selectedFood,
                  hintText: 'neues Lebensmittel',
                  itemsVisibleInDropdown: 3,
                  enabled: true,
                  items: <String>[
                    "Apfel",
                    "Milch",
                    "Mandeln",
                    "Yogurt",
                    "Brot",
                  ],
                  onValueChanged: (value) {
                    setState(() {
                      nameOfNewFood = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Hinzufügen'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[900],
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontFamily: 'CourierPrime',
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    AddDailyFoodDatabaseService(
                      uid: user.uid,
                      date: todaysDate,
                    ).addNewDailyFood(
                        nameOfNewFood, emissionsOfNewFood, originOfNewFood);
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Container(
                        width: 200,
                        child: Text(
                          'neues Lebensmittel erstellen',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'CourierPrime',
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => NewFood()));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right_alt_outlined),
                      color: Colors.grey,
                      iconSize: 40,
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildListPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      expandedHeaderPadding: EdgeInsets.symmetric(vertical: 5),
      dividerColor: Colors.lightGreen[50],
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Row(
                children: [
                  Icon(
                    item.icon,
                    size: 28,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: 25),
                  Text(
                    item.headerValue,
                    style: TextStyle(
                      fontFamily: 'GloriaHalleluja',
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            );
          },
          body: Container(
            color: Colors.lightGreen[50],
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: Text(
                    item.expandedValue,
                    style: TextStyle(
                      fontFamily: 'CourierPrime',
                      fontSize: 15,
                    ),
                  ),
                  trailing: Icon(Icons.delete),
                  onTap: () {
                    setState(() {
                      //_data.removeWhere((currentItem) => item == currentItem);
                    });
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  title: Text(
                    'Hinzufügen:',
                    style: TextStyle(
                      fontFamily: 'CourierPrime',
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  trailing: Icon(Icons.add),
                  onTap: () {
                    _showAddFood();
                  },
                ),
              ],
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildListPanel(),
    );
  }
}

class Item {
  String expandedValue, headerValue;
  IconData icon;
  bool isExpanded;

  Item(
      {this.expandedValue,
      this.headerValue,
      this.icon,
      this.isExpanded = false});
}
