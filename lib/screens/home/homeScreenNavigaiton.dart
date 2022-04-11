import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:forrest_flutter/screens/home/calender.dart';
import 'package:forrest_flutter/screens/home/compensation.dart';
import 'package:forrest_flutter/screens/home/home.dart';
import 'package:forrest_flutter/screens/home/map_local_alternative.dart';
import 'package:forrest_flutter/screens/settings/configurations.dart';
import 'package:forrest_flutter/screens/settings/profile.dart';
import 'package:forrest_flutter/services/addFoodDatabase.dart';
import 'package:forrest_flutter/services/auth.dart';
import 'package:forrest_flutter/shared/constants.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'newElement/newFood.dart';

const PROFILE_BUTTON = 'Test';
const SETTINGS_BUTTON = 'SETTINGS';
const LOGOUT_BUTTON = 'LOGOUT';

class HomeScreenNavigation extends StatefulWidget {
  @override
  _HomeScreenNavigationState createState() => _HomeScreenNavigationState();
}

class _HomeScreenNavigationState extends State<HomeScreenNavigation> {
  final AuthService _auth = AuthService();

  String newFood;
  String newActivity;
  String newTransport;
  String newConsumtion;

  final selectedFood = TextEditingController();

  bool homeIcon = true;
  int used = 0;
  int _selectedPage = 3;
  final List<Object> _pageOptions = [
    Calender(),
    MapLocalAlternative(),
    Compensation(),
    Home()
  ];
  void onSelected(BuildContext context, String item) {
    switch (item) {
      case PROFILE_BUTTON:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Profile()));
        break;
      case SETTINGS_BUTTON:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Configuration()));
        break;
    }
  }

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
            height: 500,
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
                SizedBox(height: 10),
                DropDownField(
                  controller: selectedFood,
                  hintText: 'neues Lebensmittel',
                  itemsVisibleInDropdown: 3,
                  enabled: true,
                  items: <String>[
                    "Apfel",
                    "Milch",
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
                    AddFoodDatabaseService(foodCategory: categoryOfNewFood)
                        .addNewFood(nameOfNewFood, emissionsOfNewFood, siegel,
                            originOfNewFood, sliderValue, selectedPackaging);
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

  void _showAddConsumtion() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          height: 300,
          child: Column(children: [
            Text(
              'Füge hier ein neuer Konsumartikel hinzu:',
              style: TextStyle(
                fontFamily: 'GloriaHalleluja',
                fontSize: 22.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: 'neuer Artikel',
                  fillColor: Colors.green[50],
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[50])),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[900]))),
              validator: (val) =>
                  val.isEmpty ? 'Du hast noch nichts eingegeben' : null,
              onChanged: (val) {
                setState(() => newConsumtion = val);
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
              onPressed: () {},
            ),
          ]),
        );
      },
    );
  }

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
                      Container(
                        //Bike
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
                                      setState(() => newTransport = val);
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
                                    print('turned ${(state) ? 'on' : 'off'}');
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
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //car
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
                                      setState(() => newTransport = val);
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
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //bus
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
                                      setState(() => newTransport = val);
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
                                      setState(() => newTransport = val);
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
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //plane
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
                                      setState(() => newTransport = val);
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
                              onPressed: () {},
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

  void _showAddActivties() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          height: 300,
          child: Column(children: [
            Text(
              'Füge hier eine Aktivität hinzu:',
              style: TextStyle(
                fontFamily: 'GloriaHalleluja',
                fontSize: 22.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                  hintText: 'neue Aktivität',
                  fillColor: Colors.green[50],
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[50])),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green[900]))),
              validator: (val) =>
                  val.isEmpty ? 'Du hast noch nichts eingegeben' : null,
              onChanged: (val) {
                setState(() => newActivity = val);
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
              onPressed: () {},
            ),
          ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'forRest',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'forRest',
            style: TextStyle(
              fontFamily: 'GloriaHalleluja',
              fontSize: 24.0,
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.green[900],
          actions: [
            PopupMenuButton<String>(
              padding: EdgeInsets.all(2),
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  height: 35,
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CourierPrime',
                    fontSize: 16.0,
                  ),
                  value: PROFILE_BUTTON,
                  child: Container(
                      child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.green[900],
                      ),
                      SizedBox(width: 10),
                      Text('Profil'),
                    ],
                  )),
                ),
                PopupMenuItem<String>(
                  height: 35,
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CourierPrime',
                    fontSize: 16.0,
                  ),
                  value: SETTINGS_BUTTON,
                  child: Container(
                      child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Colors.green[900],
                      ),
                      SizedBox(width: 10),
                      Text('Einstellungen'),
                    ],
                  )),
                ),
                PopupMenuDivider(),
                PopupMenuItem<String>(
                  height: 30,
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CourierPrime',
                    fontSize: 16.0,
                  ),
                  value: LOGOUT_BUTTON,
                  child: TextButton(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.green[900],
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'CourierPrime',
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      await _auth.signOut();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        body: _pageOptions[_selectedPage],
        floatingActionButton: Container(
          height: 70,
          width: 70,
          child: FittedBox(
            child: FloatingActionButton(
              child: Icon(
                _selectedPage == 3 ? Icons.add : Icons.cottage_outlined,
                size: _selectedPage == 3 ? 50 : 30,
              ),
              onPressed: () async {
                if (_selectedPage == 3) {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Container(
                          height: 150,
                          child: Column(
                            children: [
                              Text(
                                'Wähle eine Kategorie:',
                                style: TextStyle(
                                  fontFamily: 'GloriaHalleluja',
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen[100],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.lunch_dining_outlined),
                                      iconSize: 35,
                                      color: Colors.grey[800],
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _showAddFood();
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen[100],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                          Icons.local_grocery_store_outlined),
                                      iconSize: 35,
                                      color: Colors.grey[800],
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _showAddConsumtion();
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen[100],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: IconButton(
                                      icon:
                                          Icon(Icons.directions_bike_outlined),
                                      iconSize: 35,
                                      color: Colors.grey[800],
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _showAddTransport();
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen[100],
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons
                                          .pending_actions_outlined), //pending_actions_outlined  tips_and_updates_outlined    donut_large_outlined
                                      iconSize: 35,
                                      color: Colors.grey[800],
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _showAddActivties();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  setState(() {
                    _selectedPage = 3;
                  });
                }
              },
              backgroundColor: Colors.green[900],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: CircularNotchedRectangle(),
          child: Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: Colors.white, primaryColor: Colors.grey),
            child: BottomNavigationBar(
              backgroundColor: Colors.green[900],
              fixedColor: Colors.white,
              unselectedItemColor: Colors.grey[100],
              iconSize: 33,
              currentIndex: _selectedPage,
              onTap: (int index) {
                setState(() {
                  _selectedPage = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.event_outlined),
                    label: 'Kalender',
                    backgroundColor: Colors.green[900]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.location_on_outlined),
                    label: 'Karte',
                    backgroundColor: Colors.green[900]),
                BottomNavigationBarItem(
                    icon: Icon(Icons.park_outlined),
                    label: 'Ausgleich',
                    backgroundColor: Colors.green[900]),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.ac_unit,
                    color: Colors.green[900],
                    size: 0,
                  ),
                  label: '',
                  backgroundColor: Colors.green[900],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
