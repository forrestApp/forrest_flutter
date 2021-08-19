import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forrest_flutter/services/dailyDatabase/addDailyTransport.dart';
import 'package:forrest_flutter/shared/constants.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser;

final firestoreInstance = FirebaseFirestore.instance;

String newTransportDistance = '';
int transportEmissionFactor = 0;
int transportEmissions = 0;
String transportCategory = '';
String todaysDate = DateFormat.yMMMd().format(DateTime.now());

class ExpansionListTransport extends StatefulWidget {
  @override
  _ExpansionListTransportState createState() => _ExpansionListTransportState();
}

class _ExpansionListTransportState extends State<ExpansionListTransport> {
  List<Item> _data = [
    Item(
      icon: Icons.directions_bike_outlined,
      headerValue: 'Transport',
      expandedValue: 'Du bist eine Stunde mit dem Auto gefahren',
    ),
  ];

  String todaysDate = DateFormat.yMMMd().format(DateTime.now());

  void _showAddTransport() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Scaffold(
            body: DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    'neuer Transportweg:',
                    style: TextStyle(
                      fontFamily: 'GloriaHalleluja',
                      fontSize: 25,
                    ),
                  ),
                  backgroundColor: Colors.green[900],
                  bottom: TabBar(
                    indicatorColor: Colors.green[900],
                    tabs: [
                      Tab(icon: Icon(Icons.directions_bike_outlined)),
                      Tab(icon: Icon(Icons.directions_car_outlined)),
                      Tab(icon: Icon(Icons.directions_bus_filled_outlined)),
                      Tab(icon: Icon(Icons.flight_outlined)),
                    ],
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TabBarView(
                    children: [
                      // Fahrrad
                      Container(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    'Strecke:',
                                    style: TextStyle(
                                      fontFamily: 'CourierPrime',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Fahrradstrecke',
                                        fillColor: Colors.green[50],
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[50])),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[900]))),
                                    validator: (val) => val.isEmpty
                                        ? 'Du hast noch nichts eingegeben'
                                        : null,
                                    onChanged: (val) {
                                      setState(() {
                                        newTransportDistance = val;
                                        transportCategory = 'Fahrrad';
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'km',
                                  style: TextStyle(
                                    fontFamily: 'CourierPrime',
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'E-Bike?',
                                  style: TextStyle(
                                    fontFamily: 'CourierPrime',
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(width: 80),
                                LiteRollingSwitch(
                                  value: false,
                                  textOn: '',
                                  textOff: '',
                                  colorOn:
                                      Colors.lightGreen[400].withOpacity(0.8),
                                  colorOff: Colors.orange[200],
                                  iconOn: Icons.check,
                                  iconOff: Icons.close,
                                  onChanged: (bool state) {
                                    transportCategory =
                                        (state) ? 'E-Bike' : 'Fahrrad';
                                  },
                                ),
                              ],
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
                                calculateEmissions();
                              },
                            ),
                          ],
                        ),
                      ),
                      // Auto
                      Container(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    'Strecke:',
                                    style: TextStyle(
                                      fontFamily: 'CourierPrime',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Autostrecke',
                                        fillColor: Colors.green[50],
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[50])),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[900]))),
                                    validator: (val) => val.isEmpty
                                        ? 'Du hast noch nichts eingegeben'
                                        : null,
                                    onChanged: (val) {
                                      newTransportDistance = val;
                                      transportCategory =
                                          'Auto'; // hier muss noch das vom Nutzer gespeicherte Automodell ausgelesen werden
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'km',
                                  style: TextStyle(
                                    fontFamily: 'CourierPrime',
                                    fontSize: 20,
                                  ),
                                ),
                              ],
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
                                calculateEmissions();
                              },
                            ),
                          ],
                        ),
                      ),
                      // Bus/Bahn
                      Container(
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    'Bus:',
                                    style: TextStyle(
                                      fontFamily: 'CourierPrime',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Busstrecke',
                                        fillColor: Colors.green[50],
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[50])),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[900]))),
                                    validator: (val) => val.isEmpty
                                        ? 'Du hast noch nichts eingegeben'
                                        : null,
                                    onChanged: (val) {
                                      newTransportDistance = val;
                                      transportCategory =
                                          int.parse(newTransportDistance) < 25
                                              ? 'Bus (Nahverkehr)'
                                              : 'Bus (Fernverkehr)';
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'km',
                                  style: TextStyle(
                                    fontFamily: 'CourierPrime',
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    'Bahn:',
                                    style: TextStyle(
                                      fontFamily: 'CourierPrime',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Bahnstrecke',
                                        fillColor: Colors.green[50],
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[50])),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[900]))),
                                    validator: (val) => val.isEmpty
                                        ? 'Du hast noch nichts eingegeben'
                                        : null,
                                    onChanged: (val) {
                                      newTransportDistance = val;
                                      transportCategory =
                                          int.parse(newTransportDistance) < 25
                                              ? 'Bahn (Nahverkehr)'
                                              : 'Bahn (Fernverkehr)';
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'km',
                                  style: TextStyle(
                                    fontFamily: 'CourierPrime',
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
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
                                calculateEmissions();
                              },
                            ),
                          ],
                        ),
                      ),
                      // Flugzeug
                      Container(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    'Strecke:',
                                    style: TextStyle(
                                      fontFamily: 'CourierPrime',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Container(
                                  width: 150,
                                  child: TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Flugstrecke',
                                        fillColor: Colors.green[50],
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[50])),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[900]))),
                                    validator: (val) => val.isEmpty
                                        ? 'Du hast noch nichts eingegeben'
                                        : null,
                                    onChanged: (val) {
                                      newTransportDistance = val;
                                      transportCategory =
                                          int.parse(newTransportDistance) < 25
                                              ? 'innerdeutscher Flug'
                                              : 'grenzüberschreitender Flug';
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'km',
                                  style: TextStyle(
                                    fontFamily: 'CourierPrime',
                                    fontSize: 20,
                                  ),
                                ),
                              ],
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
                                calculateEmissions();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void calculateEmissions() async {
    // getTransportEmissionFactor(); // Faktor kann nicht ausgelesen werden

    await FirebaseFirestore.instance
        .collection('Trasport')
        .doc(transportCategory)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        transportEmissionFactor = documentSnapshot['Emissionen'] ?? [];
      } else {
        print('Document does not exist on the database');
      }
    });

    // Emissionen aus Transportmittel-Emissionsfaktor und Strecke berechnen
    transportEmissions =
        int.parse(newTransportDistance) * transportEmissionFactor;

    // In den Tagesverlauf des Nutzers eintragen
    AddDailyTransportDatabaseService(
      uid: user.uid,
      date: todaysDate,
    ).addNewDailyTransport(transportCategory, transportEmissions);
    Navigator.pop(context);

    // auf dem Home-Screen aktualisieren
  }

  void getTransportEmissionFactor() async {
    FirebaseFirestore.instance
        .collection('Trasport')
        .doc('Fahrrad')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        transportEmissionFactor = documentSnapshot['Emissionen'] ?? [];
        print('Document data: $transportEmissionFactor');
      } else {
        print('Document does not exist on the database');
      }
    });
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
                    size: 30,
                    color: Colors.grey[600],
                  ),
                  SizedBox(width: 20),
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
                    //setState(() {
                    //  _data.removeWhere((currentItem) => item == currentItem);
                    //});
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
                    _showAddTransport();
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
