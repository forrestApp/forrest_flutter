import 'package:flutter/material.dart';
import 'package:forrest_flutter/screens/home/calender.dart';
import 'package:forrest_flutter/screens/home/compensation.dart';
import 'package:forrest_flutter/screens/home/home.dart';
import 'package:forrest_flutter/screens/home/map_local_alternative.dart';
import 'package:forrest_flutter/screens/settings/configurations.dart';
import 'package:forrest_flutter/screens/settings/profile.dart';
import 'package:forrest_flutter/services/auth.dart';

class HomeScreenNavigation extends StatefulWidget {
  @override
  _HomeScreenNavigationState createState() => _HomeScreenNavigationState();
}

class _HomeScreenNavigationState extends State<HomeScreenNavigation> {
  final AuthService _auth = AuthService();

  bool homeIcon = true;
  int used = 0;
  int _selectedPage = 3;
  final List<Object> _pageOptions = [
    Calender(),
    MapLocalAlternative(),
    Compensation(),
    Home()
  ];
  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Profile()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Configuration()));
        break;
    }
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
            PopupMenuButton<int>(
              padding: EdgeInsets.all(2),
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(
                  height: 35,
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CourierPrime',
                    fontSize: 16.0,
                  ),
                  value: 0,
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
                PopupMenuItem<int>(
                  height: 35,
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CourierPrime',
                    fontSize: 16.0,
                  ),
                  value: 1,
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
                PopupMenuItem<int>(
                  height: 30,
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontFamily: 'CourierPrime',
                    fontSize: 16.0,
                  ),
                  value: 2,
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
                  setState(() {
                    used = 1;
                  });
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
