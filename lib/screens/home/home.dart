import 'package:flutter/material.dart';
import 'package:forrest_flutter/screens/home/calender.dart';
import 'package:forrest_flutter/screens/home/compensation.dart';
import 'package:forrest_flutter/screens/home/map_local_alternative.dart';
import 'package:forrest_flutter/screens/home/profileSettings.dart';
import 'package:forrest_flutter/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int used = 0;
  //int _currentIndex = 0;

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfileSettings()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: 30,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'CourierPrime',
                  fontSize: 16.0,
                ),
                value: 0,
                child: Container(
                    child: Row(
                  children: [
                    SizedBox(width: 5),
                    Icon(
                      Icons.settings,
                      size: 28,
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
                value: 1,
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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.0),
            Text(
              'Willkommen in der App!',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'GloriaHalleluja',
                fontSize: 30.0,
              ),
            ),
            Divider(
              height: 60.0,
              color: Colors.lightGreen[500],
            ),
            SizedBox(height: 20.0),
            Text(
              'dein heutiger Stand:',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'CourierPrime',
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.lightGreen[100],
                  ),
                  width: 65,
                  height: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '2,74',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'CO2-Budget',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 10.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 20,
                  height: 25,
                  child: Text(
                    '-',
                    style: TextStyle(
                      fontFamily: 'CourierPrime',
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 65,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.lightGreen[100],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$used',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'verbraucht',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 20,
                  height: 25,
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontFamily: 'CourierPrime',
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 65,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.lightGreen[100],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '24',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'gepflanzt',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 10.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 20,
                  height: 25,
                  child: Text(
                    '=',
                    style: TextStyle(
                      fontFamily: 'CourierPrime',
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 65,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.lightGreen[100],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '274',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Bilanz',
                        style: TextStyle(
                          fontFamily: 'CourierPrime',
                          fontSize: 10.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            used += 1;
          });
        },
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 70.0,
            height: 0.98,
            fontFamily: 'CourierPrime',
          ),
        ),
        backgroundColor: Colors.green[900],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green[900],
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20),
            IconButton(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              color: Colors.white,
              onPressed: () {},
            ),
            SizedBox(width: 22),
            IconButton(
              icon: Icon(
                Icons.map,
                size: 28,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MapLocalAlternative()));
              },
            ),
            SizedBox(width: 22),
            IconButton(
              icon: Icon(
                Icons.calendar_today,
                size: 28,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Calender()));
              },
            ),
            SizedBox(width: 22),
            IconButton(
              icon: Icon(
                Icons.payment,
                size: 32,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Compensation()));
              },
            ),
          ],
        ),

        /*currentIndex: _currentIndex,
        backgroundColor: Colors.green[900],
        unselectedItemColor: Colors.green[200],
        selectedItemColor: Colors.white,
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_sharp),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Karte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Kalender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outlined),
            label: 'Ausgleich',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },*/
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
