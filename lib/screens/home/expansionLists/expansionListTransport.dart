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

const TRANSPORT_COLLECTION = 'Trasport';

List todaysListedTransports = ['Auto', 'Fahrrad', 'Auto2'];

int transportDistance = 0;
int transportEmissionFactor = 0;
int transportEmissions = 0;
String transportCategory = '';
String todaysDate = DateFormat.yMMMd().format(DateTime.now());

int currentNumberOfPassengers = 0;

class ExpansionListTransport extends StatefulWidget {
  @override
  _ExpansionListTransportState createState() => _ExpansionListTransportState();
}

class _ExpansionListTransportState extends State<ExpansionListTransport> {
  String todaysDate = DateFormat.yMMMd().format(DateTime.now());

  List<Item> _data = [
    Item(
      icon: Icons.directions_bike_outlined,
      headerValue: 'Transport',
      expandedValue: todaysListedTransports,
    ),
  ];

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
                                        transportDistance = int.parse(val);
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
                                      transportDistance = int.parse(val);
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 120,
                                  child: Text(
                                    'Mitfahrer:',
                                    style: TextStyle(
                                      fontFamily: 'CourierPrime',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30),
                                Container(
                                  width: 40,
                                  child: TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        hintText: '0',
                                        fillColor: Colors.green[50],
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[50])),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green[900]))),
                                    validator: (val) => val.isEmpty &&
                                            int.parse(val) != 0
                                        ? 'Du hast noch nichts oder keine Zahl eingegeben'
                                        : null,
                                    onChanged: (val) {
                                      currentNumberOfPassengers =
                                          int.parse(val);
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Person(en)',
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
                                      transportDistance = int.parse(val);
                                      transportCategory = transportDistance < 25
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
                                      transportDistance = int.parse(val);
                                      transportCategory = transportDistance < 25
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
                                      transportDistance = int.parse(val);
                                      transportCategory = transportDistance < 25
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
    await FirebaseFirestore.instance
        .collection(TRANSPORT_COLLECTION)
        .doc(transportCategory)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        transportEmissionFactor = documentSnapshot['Emissionen'] ?? [];
      } else {
        print('Kategorie nicht vorhanden');
      }
    });

    // Emissionen aus Transportmittel-Emissionsfaktor und Strecke berechnen
    transportEmissions = transportDistance * transportEmissionFactor;

    if (currentNumberOfPassengers != 0) {
      transportEmissions =
          (transportEmissions / (currentNumberOfPassengers + 1)).round();
    }

    // In den Tagesverlauf des Nutzers eintragen
    AddDailyTransportDatabaseService(
      uid: user.uid,
      date: todaysDate,
    ).addNewDailyTransport(
        transportCategory, transportDistance, transportEmissions);
    Navigator.pop(context);

    // auf dem Home-Screen aktualisieren
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
          body: Container(),
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
  String headerValue;
  List expandedValue;
  IconData icon;
  bool isExpanded;

  Item(
      {this.expandedValue,
      this.headerValue,
      this.icon,
      this.isExpanded = false});
}
